//
//  TimelinePresenterTest.swift
//  ViperTwitterClientTests
//
//  Created by hirothings on 2018/01/20.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import XCTest
import RxSwift
import TwitterKit

@testable import ViperTwitterClientModel
@testable import ViperTwitterClientModules

enum TweetMock {
    case none
    case initialTweets
    case additionalTweets
    
    func generate() -> [Tweet] {
        switch self {
        case .none:
            return []
        case .initialTweets:
            return Array(0..<20).map {
                let user = User(name: "ユーザー\($0)", screenName: "test_\($0)", description: "",
                                profileImageURL: "https://test\($0).com", profileBGImageURL: "https://test\($0).com", friendsCount: $0, followersCount: $0)
                return Tweet(id: Int64($0), text: "こんにちは！\($0)", user: user, retweetCount: $0, favCount: $0, media: nil)
            }
        case .additionalTweets:
            return Array(0..<18).map {
                let user = User(name: "追加ユーザー\($0)", screenName: "test_\($0)", description: "",
                                profileImageURL: "https://test\($0).com", profileBGImageURL: "https://test\($0).com", friendsCount: $0, followersCount: $0)
                return Tweet(id: Int64($0), text: "追加ユーザーです。こんにちは！\($0)", user: user, retweetCount: $0, favCount: $0, media: nil)
            }
        }
    }
}

class TimelineUseCaseStub: TimelineUsecase {
    var mock: TweetMock!
    var output: TimelineInteractorOutput!
    private let bag = DisposeBag()
    
    func fetch(with userID: String) {
        Observable.just(mock.generate())
            .subscribe(
                onNext: { [weak self] (tweets: [Tweet]) in
                    self?.output.tweetsFetched(tweets)
                },
                onError: { [weak self] error in
                    self?.output.tweetsFetchFailed(error)
                }
            )
            .disposed(by: bag)
    }
    
    func addTweets(userID: String, maxID: Int64) {
        Observable.just(mock.generate())
            .subscribe(
                onNext: { [weak self] (tweets: [Tweet]) in
                    self?.output.tweetsAdded(tweets)
                },
                onError: { [weak self] error in
                    self?.output.tweetsFetchFailed(error)
                }
            )
            .disposed(by: bag)
    }
}

class TimelineViewSpy: UIViewController, TimelineView {
    var presenter: TimelinePresentation!
    var tweets: [Tweet] = []
    var tweetsDiffCount: Int = 0
    var calledFanctions: [String] = []
    
    func showNoContentView() {
        calledFanctions.append(#function)
    }
    
    func showTimeline(tweets: [Tweet]) {
        self.tweets = tweets
    }
    
    func updateTimeline(tweets: [Tweet], tweetsDiff: CountableRange<Int>) {
        self.tweetsDiffCount = tweetsDiff.count
    }
}

class TimelinePresenterTest: XCTestCase {
    var presenter: TimelinePresenter!
    let spy = TimelineViewSpy()
    lazy var router = TimelineRouter(viewController: nil)
    let stub = TimelineUseCaseStub()
    let userID: String = "602524897"
    let store = TWTRTwitter.sharedInstance().sessionStore
    var tweets: [Tweet] = []
    var isLoading = false
    
    override func setUp() {
        super.setUp()
        presenter = TimelinePresenter(view: spy, router: router, interactor: stub)
        spy.presenter = presenter
        stub.output = presenter
    }
    
    /// Tweet0件の場合、0件表示メソッドがコールされていること
    func testFetchNone() {
        // setup mock
        stub.mock = TweetMock.none
        // when
        presenter.viewDidLoad()
        // then
        XCTAssertEqual(spy.calledFanctions.filter { $0 == "showNoContentView()" }.count, 1)
    }
    
    /// Tweetを追加ロードした際、追加の差分がviewに正常に渡されていること
    func testAddedTweets() {
        stub.mock = TweetMock.initialTweets
        presenter.viewDidLoad()
        XCTAssertEqual(20, spy.tweets.count)
        
        stub.mock = TweetMock.additionalTweets
        presenter.reachedBottom()
        XCTAssertEqual(18, spy.tweetsDiffCount)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

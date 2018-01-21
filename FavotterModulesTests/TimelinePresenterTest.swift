//
//  TimelinePresenterTest.swift
//  FavotterModulesTests
//
//  Created by hirothings on 2018/01/20.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import XCTest
import RxSwift
import TwitterKit

@testable import FavotterModel
@testable import FavotterModules

enum TweetMock {
    case none
    case initialTweets
    case additionalTweets
    // memo: 画像付きのツイートなどパターンはここに追加していく(UITestでも使えそう)
    
    func generate() -> [Tweet] {
        switch self {
        case .none:
            return []
        case .initialTweets:
            return Array(1..<20).map {
                let user = User(name: "ユーザー\($0)", screenName: "test_\($0)", description: "", profileImageURL: "https://test\($0).com", profileBGImageURL: "https://test\($0).com", friendsCount: $0, followersCount: $0)
                return Tweet(id: Int64($0), text: "こんにちは！\($0)", user: user, retweetCount: $0, favCount: $0)
            }
        case .additionalTweets:
            return Array(1..<20).map {
                let user = User(name: "追加ユーザー\($0)", screenName: "test_\($0)", description: "", profileImageURL: "https://test\($0).com", profileBGImageURL: "https://test\($0).com", friendsCount: $0, followersCount: $0)
                return Tweet(id: Int64($0), text: "追加ユーザーです。こんにちは！\($0)", user: user, retweetCount: $0, favCount: $0)
            }
        }
    }
}

class TimelineUseCaseStub: TimelineUsecase {
    var mock: TweetMock!
    
    func fetch(with userID: String) -> Observable<[Tweet]> {
        return Observable.just(mock.generate())
    }
    
    func addTweets(userID: String, maxID: Int64) -> Observable<[Tweet]> {
        return Observable.just(mock.generate())
    }
}

class TimelinePresenterTest: XCTestCase {
    var presenter: TimelinePresentation!
    let view = StoryboardScene.TimelineViewController.initialScene.instantiate()
    lazy var router = TimelineRouter(viewController: view)
    let stub = TimelineUseCaseStub()
    let userID: String = "602524897" // @hirothings
    let store = TWTRTwitter.sharedInstance().sessionStore
    var tweets: [Tweet] = []
    var isLoading = false
    
    override func setUp() {
        super.setUp()
        self.presenter = TimelinePresenter(view: view, router: router, interactor: stub)
        view.presenter = self.presenter
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Tweet0件の場合、0件表示viewが表示されること
    func testFetchNone() {
        // setup mock
        stub.mock = TweetMock.none
        // when
        presenter.viewDidLoad()
        // then
        XCTAssertEqual(false, view.noContentView.isHidden)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

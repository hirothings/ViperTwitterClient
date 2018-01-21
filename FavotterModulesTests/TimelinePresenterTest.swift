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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

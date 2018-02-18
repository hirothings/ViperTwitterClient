//
//  UserTimelineInteractor.swift
//  Favotter
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import Foundation
import RxSwift
import FavotterModel

protocol UserTimelineUsecase: class {
    var output: TimelineInteractorOutput! { get }
    func fetch(with screenName: String)
    func addTweets(screenName: String, maxID: Int64)
}

class UserTimelineInteractor: UserTimelineUsecase {
    var output: TimelineInteractorOutput!
    private let bag = DisposeBag()
    private let client = APIClient()

    func fetch(with screenName: String) {
        let request = TwitterAPI.UserTimeline(screenName: screenName, maxID: nil)
        client.call(request: request)
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
    
    func addTweets(screenName: String, maxID: Int64) {
        let request = TwitterAPI.UserTimeline(screenName: screenName, maxID: maxID)
        client.call(request: request)
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

//
//  TimelineInteractor.swift
//  FavotterModel
//
//  Created by hirothings on 2017/12/28.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation
import RxSwift
import FavotterModel

protocol TimelineUsecase: class {
    var output: TimelineInteractorOutput! { get }
    func fetch(with userID: String)
    func addTweets(userID: String, maxID: Int64)
}

class TimelineInteractor: TimelineUsecase {
    var output: TimelineInteractorOutput!
    private let bag = DisposeBag()
    private let client = APIClient()

    func fetch(with userID: String) {
        let request = TwitterAPI.HomeTimeline(userID: userID, maxID: nil)
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
    
    func addTweets(userID: String, maxID: Int64) {
        let request = TwitterAPI.HomeTimeline(userID: userID, maxID: maxID)
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

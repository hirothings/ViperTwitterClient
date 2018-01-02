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
    weak var output: UserTimelineInteractorOutput! { get }
    func fetch(with screenName: String)
}

protocol UserTimelineInteractorOutput: class {
    func tweetsFetched(_ tweets: [Tweet])
    func tweetsFetchFailed()
}

class UserTimelineInteractor: UserTimelineUsecase {
    weak var output: UserTimelineInteractorOutput!
    private let bag = DisposeBag()
    
    func fetch(with screenName: String) {
        let client = APIClient()
        let request = TwitterAPI.UserTimeline(screenName: screenName)
        client.call(request: request)
            .subscribe(
                onNext: { [weak self] (tweets: [Tweet]) in
                    self?.output.tweetsFetched(tweets)
                },
                onError: { [weak self] _ in
                    self?.output.tweetsFetchFailed()
                }
            )
            .disposed(by: bag)
    }
}

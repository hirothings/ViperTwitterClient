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

public protocol TimelineUsecase: class {
    weak var output: TimelineInteractorOutput! { get }
    func fetch(with userID: String)
}

public protocol TimelineInteractorOutput: class {
    func tweetsFetched(_ tweets: [Tweet])
    func tweetsFetchFailed()
}

public class TimelineInteractor: TimelineUsecase {
    public weak var output: TimelineInteractorOutput!
    private let bag = DisposeBag()
    
    public init() {}
    
    public func fetch(with userID: String) {
        let client = APIClient()
        let request = TwitterAPI.HomeTimeline(userID: userID)
        client.call(request: request)
            .subscribe(
                onNext: { [weak self] (tweets: [Tweet]) in
                    self?.output.tweetsFetched(tweets)
                },
                onError: { [weak self] error in
                    dump(error)
                    self?.output.tweetsFetchFailed()
                }
            )
            .disposed(by: bag)
    }
}

//
//  TweetsInteractor.swift
//  FavotterModel
//
//  Created by hirothings on 2017/12/28.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation
import RxSwift
import FavotterAPIClient

public protocol TweetsInteractorUsecase: class {
    weak var output: TweetsInteractorOutput! { get }
    func fetch(with userID: String)
}

public protocol TweetsInteractorOutput: class {
    func tweetsFetched(_ tweets: [Tweet])
    func tweetsFetchFailed()
}

public class TweetsInteractor: TweetsInteractorUsecase {
    public weak var output: TweetsInteractorOutput!
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

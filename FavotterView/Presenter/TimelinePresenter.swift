//
//  TimelinePresenter.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation
import RxSwift
import FavotterDomain
import FavotterAPIClient

protocol TimelinePresentation {
    weak var view: TimelineView? { get }
    var router: TimelineWireframe! { get }
    var interactor: TweetsInteractorInput! { get }
    var output: TweetsInteractorOutput! { get }
    
    func viewDidLoad()
}

class TimelinePresenter: TimelinePresentation {
    weak var view: TimelineView?
    var router: TimelineWireframe!
    var interactor: TweetsInteractorInput!
    var output: TweetsInteractorOutput!
    var tweets: [Tweet] = []
    
    private let bag = DisposeBag()
    
    func viewDidLoad() {
        interactor.fetch(with: "hirothings")
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

extension TimelinePresenter: TweetsInteractorOutput {
    func tweetsFetched(_ tweets: [Tweet]) {
    }
    
    func tweetsFetchFailed() {
    }
}

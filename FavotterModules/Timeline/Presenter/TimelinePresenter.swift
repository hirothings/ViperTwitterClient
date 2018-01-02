//
//  TimelinePresenter.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation
import RxSwift
import FavotterModel

protocol TimelinePresentation {
    weak var view: TimelineView? { get }
    var router: TimelineWireframe! { get }
    var interactor: TweetsInteractorUsecase! { get }
    var output: TweetsInteractorOutput! { get }
    
    func viewDidLoad()
    func pullToRefresh()
}

class TimelinePresenter: TimelinePresentation {
    weak var view: TimelineView?
    var router: TimelineWireframe!
    var interactor: TweetsInteractorUsecase!
    var output: TweetsInteractorOutput!
    var tweets: [Tweet] = [] {
        didSet {
            if tweets.isEmpty {
                view?.showNoContentView()
            } else {
                view?.showTimeline(tweets: tweets)
            }
        }
    }
    
    private let bag = DisposeBag()
    
    func viewDidLoad() {
        interactor.fetch(with: "hirothings")
    }
    
    func pullToRefresh() {
        interactor.fetch(with: "hirothings")
    }
}

extension TimelinePresenter: TweetsInteractorOutput {
    func tweetsFetched(_ tweets: [Tweet]) {
        self.tweets = tweets
    }
    
    func tweetsFetchFailed() {
    }
}

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
import TwitterKit

protocol TimelinePresentation: class {
    weak var view: TimelineView? { get }
    
    init(
        view: TimelineView?,
        router: TimelineWireframe,
        interactor: TimelineUsecase
    )
    
    func viewDidLoad()
    func pullToRefresh()
    func didSelectTweet(with user: User)
    func reachedBottom()
}

class TimelinePresenter: TimelinePresentation {
    weak var view: TimelineView?
    private let router: TimelineWireframe
    private let interactor: TimelineUsecase
    private let userID: String
    private let store = TWTRTwitter.sharedInstance().sessionStore
    private var tweets: [Tweet] = []
    private var isLoading = false

    required init(
        view: TimelineView?,
        router: TimelineWireframe,
        interactor: TimelineUsecase
        ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.userID = store.session()?.userID ?? ""
    }
    
    private let bag = DisposeBag()
    
    func viewDidLoad() {
        interactor.fetch(with: userID)
    }
    
    func pullToRefresh() {
        interactor.fetch(with: userID)
    }
    
    func didSelectTweet(with user: User) {
        router.pushUserProfileView(user)
    }
    
    func reachedBottom() {
        guard let lastID = tweets.last?.id else { return }
        if isLoading { return }
        interactor.addTweets(userID: userID, maxID: lastID)
        isLoading = true
    }
}

extension TimelinePresenter: TimelineInteractorOutput {
    func tweetsFetched(_ tweets: [Tweet]) {
        isLoading = false
        if tweets.isEmpty {
            view?.showNoContentView()
        } else {
            self.tweets = tweets
            view?.showTimeline(tweets: tweets)
        }
    }
    
    func tweetsAdded(_ tweets: [Tweet]) {
        isLoading = false
        if tweets.isEmpty {
            return
        }
        self.tweets += tweets
        view?.updateTimeline(tweets: self.tweets)
    }
    
    func tweetsFetchFailed() {
        isLoading = false
    }
}

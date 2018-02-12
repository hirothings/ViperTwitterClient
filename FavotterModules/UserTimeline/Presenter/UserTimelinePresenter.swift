//
//  UserTimelinePresenter.swift
//  Favotter
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import Foundation
import FavotterModel

protocol UserTimelinePresentation: class {
    init(
        view: UserTimelineView,
        router: UserTimelineWireframe,
        interactor: UserTimelineUsecase
    )
    
    func fetchUserTimeline(user: User)
}

class UserTimelinePresenter: UserTimelinePresentation {
    private weak var view: UserTimelineView?
    private let router: UserTimelineWireframe
    private let interactor: UserTimelineUsecase
    
    var tweets: [Tweet] = [] {
        didSet {
            if tweets.isEmpty {
                view?.showNoContentView()
            } else {
                view?.showTimeline(tweets: tweets)
            }
        }
    }
    
    required init(
        view: UserTimelineView,
        router: UserTimelineWireframe,
        interactor: UserTimelineUsecase
        ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func fetchUserTimeline(user: User) {
        interactor.fetch(with: user.screenName)
    }
}

extension UserTimelinePresenter: UserTimelineInteractorOutput {
    func tweetsFetched(_ tweets: [Tweet]) {
        self.tweets = tweets
    }
    
    func tweetsFetchFailed() {
    }
}

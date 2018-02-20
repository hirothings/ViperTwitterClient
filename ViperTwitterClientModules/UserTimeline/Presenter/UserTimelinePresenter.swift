//
//  UserTimelinePresenter.swift
//  ViperTwitterClient
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import Foundation
import ViperTwitterClientModel

protocol UserTimelinePresentation: class {
    init(
        view: TimelineView,
        router: UserTimelineWireframe,
        interactor: UserTimelineUsecase
    )
    
    func fetchUserTimeline(user: User)
}

class UserTimelinePresenter: UserTimelinePresentation {
    var view: TimelineView?
    var tweets: [Tweet] = []
    var isLoading = false
    private let router: UserTimelineWireframe
    private let interactor: UserTimelineUsecase
    
    required init(
        view: TimelineView,
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
    
    func reachedBottom(user: User) {
        guard let lastID = tweets.last?.id else { return }
        if isLoading { return }
        isLoading = true
        interactor.addTweets(screenName: user.screenName, maxID: lastID)
    }
}

extension UserTimelinePresenter: TimelineInteractorOutput {}

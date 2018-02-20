//
//  TimelinePresenter.swift
//  ViperTwitterClientView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation
import RxSwift
import ViperTwitterClientModel
import TwitterKit

protocol TimelinePresentation: class {
    var view: TimelineView? { get }
    
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
    var view: TimelineView?
    var tweets: [Tweet] = []
    var isLoading = false
    private let router: TimelineWireframe
    private let interactor: TimelineUsecase
    private let userID: String
    private let store = TWTRTwitter.sharedInstance().sessionStore

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
        fetchTweets(userID)
    }
    
    func pullToRefresh() {
        fetchTweets(userID)
    }
    
    func didSelectTweet(with user: User) {
        router.pushUserProfileView(user)
    }
    
    func reachedBottom() {
        guard let lastID = tweets.last?.id else { return }
        if isLoading { return }
        isLoading = true
        interactor.addTweets(userID: userID, maxID: lastID)
    }
    
    private func fetchTweets(_ userID: String) {
        interactor.fetch(with: userID)
    }
}

extension TimelinePresenter: TimelineInteractorOutput {}

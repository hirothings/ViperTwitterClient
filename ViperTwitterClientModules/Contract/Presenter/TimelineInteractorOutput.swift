//
//  TimelineInteractorOutput.swift
//  ViperTwitterClientModules
//
//  Created by hirothings on 2018/02/18.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import Foundation
import ViperTwitterClientModel

protocol TimelineInteractorOutput: ErrorHandler {
    var view: TimelineView? { get }
    var tweets: [Tweet] { get set }
    var isLoading: Bool { get set }
    mutating func tweetsFetched(_ tweets: [Tweet])
    mutating func tweetsAdded(_ tweets: [Tweet])
    mutating func tweetsFetchFailed(_ error: Error)
}

extension TimelineInteractorOutput {
    mutating func tweetsFetched(_ tweets: [Tweet]) {
        isLoading = false
        if tweets.isEmpty {
            view?.showNoContentView()
        } else {
            self.tweets = tweets
            view?.showTimeline(tweets: tweets)
        }
    }
    
    mutating func tweetsAdded(_ tweets: [Tweet]) {
        isLoading = false
        if tweets.isEmpty {
            return
        }
        self.tweets += tweets
        view?.updateTimeline(tweets: self.tweets)
    }
    
    mutating func tweetsFetchFailed(_ error: Error) {
        isLoading = false
        let message = handleErrorMessage(error: error)
        view?.showError(message: message)
    }
}

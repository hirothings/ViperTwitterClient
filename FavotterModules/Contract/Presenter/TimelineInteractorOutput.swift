//
//  TimelineOutput.swift
//  FavotterModules
//
//  Created by hirothings on 2018/02/18.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import Foundation

protocol TimelineInteractorOutput: class {
    var view: TimelineView? { get }
    func tweetsFetched(_ tweets: [Tweet])
    func tweetsAdded(_ tweets: [Tweet])
    func tweetsFetchFailed(_ error: Error)
}

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

protocol TimelineUsecase: class {
    func fetch(with userID: String) -> Observable<[Tweet]>
    func addTweets(userID: String, maxID: Int64) -> Observable<[Tweet]>
}

class TimelineInteractor: TimelineUsecase {
    private let bag = DisposeBag()
    private let client = APIClient()

    func fetch(with userID: String) -> Observable<[Tweet]> {
        let request = TwitterAPI.HomeTimeline(userID: userID, maxID: nil)
        return client.call(request: request)
    }
    
    func addTweets(userID: String, maxID: Int64) -> Observable<[Tweet]> {
        let request = TwitterAPI.HomeTimeline(userID: userID, maxID: maxID)
        return client.call(request: request)
    }
}

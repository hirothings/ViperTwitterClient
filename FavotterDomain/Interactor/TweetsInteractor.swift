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

protocol TweetsInteractorInput {}

public class TweetsInteractor: TweetsInteractorInput {
    
    public func fetch(with userID: String) -> Observable<[Tweet]> {
        let client = APIClient()
        let request = TwitterAPI.HomeTimeline(userID: userID)
        return client.call(request: request)
    }
}

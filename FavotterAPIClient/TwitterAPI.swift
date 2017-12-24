//
//  TwitterAPI.swift
//  Favotter
//
//  Created by hirothings on 2017/06/11.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation
import FavotterModel

public final class TwitterAPI {
    
    public struct HomeTimeline: TwitterRequest {
        public typealias Response = [Tweet]
        
        public var urlString: String {
            return baseURL + "/statuses/home_timeline.json"
        }
        public var parameters: [AnyHashable: Any]? {
            return ["user_id": userID]
        }
        
        private let userID: String

        public init(userID: String) {
            self.userID = userID
        }
    }
    
    public struct UserTimeline: TwitterRequest {
        public typealias Response = User
        
        public var urlString: String {
            return baseURL + "/statuses/user_timeline.json"
        }
        public var parameters: [AnyHashable: Any]? {
            return ["screen_name": screenName]
        }
        
        private let screenName: String
        
        public init(screenName: String) {
            self.screenName = screenName
        }
    }
    
    
}

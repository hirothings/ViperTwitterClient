//
//  TwitterAPI.swift
//  ViperTwitterClient
//
//  Created by hirothings on 2017/06/11.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation

public final class TwitterAPI {
    
    public struct HomeTimeline: TwitterRequest {
        public typealias Response = [Tweet]
        
        public var urlString: String {
            return baseURL + "/statuses/home_timeline.json"
        }
        public var parameters: [AnyHashable: Any]? {
            var param: [AnyHashable: Any] = [
                "user_id": userID,
                "count": "20"
            ]
            if let maxID = maxID {
                param["max_id"] = "\(maxID - 1)"
            }
            return param
        }
        
        private let userID: String
        private let maxID: Int64?

        public init(userID: String, maxID: Int64?) {
            self.userID = userID
            self.maxID = maxID
        }
    }
    
    public struct UserTimeline: TwitterRequest {
        public typealias Response = [Tweet]

        public var urlString: String {
            return baseURL + "/statuses/user_timeline.json"
        }
        public var parameters: [AnyHashable: Any]? {
            var param: [AnyHashable: Any] = [
                "screen_name": screenName,
                "count": "20"
            ]
            if let maxID = maxID {
                param["max_id"] = "\(maxID - 1)"
            }
            return param
        }
        
        private let screenName: String
        private let maxID: Int64?
        
        public init(screenName: String, maxID: Int64?) {
            self.screenName = screenName
            self.maxID = maxID
        }
    }
    
    
}

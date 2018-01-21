//
//  Tweet.swift
//  FavotterModel
//
//  Created by hirothings on 2017/12/22.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation

public struct Tweet: Codable {
    public let id: Int64
    public let text: String
    public let user: User
    public let retweetCount: Int
    public let favCount: Int
    
    public init(id: Int64, text: String, user: User, retweetCount: Int, favCount: Int) {
        self.id = id
        self.text = text
        self.user = user
        self.retweetCount = retweetCount
        self.favCount = favCount
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case user
        case retweetCount = "retweet_count"
        case favCount = "favorite_count"
    }
}

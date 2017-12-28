//
//  Tweet.swift
//  FavotterModel
//
//  Created by hirothings on 2017/12/22.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation

public struct Tweet: Codable {
    let text: String
    let user: User
    let retweetCount: Int
    let favCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case text
        case user
        case retweetCount = "retweet_count"
        case favCount = "favorite_count"
    }
}

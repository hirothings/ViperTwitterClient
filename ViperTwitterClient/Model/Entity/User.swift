//
//  User.swift
//  ViperTwitterClientModel
//
//  Created by hirothings on 2017/12/22.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation

public struct User: Codable {
    public let name: String
    public let screenName: String
    public let description: String
    public let profileImageURL: String
    public let profileBGImageURL: String?
    public let friendsCount: Int
    public let followersCount: Int
    
    public init(
        name: String,
        screenName: String,
        description: String,
        profileImageURL: String,
        profileBGImageURL: String?,
        friendsCount: Int,
        followersCount: Int
        ) {
        self.name = name
        self.screenName = screenName
        self.description = description
        self.profileImageURL = profileImageURL
        self.profileBGImageURL = profileBGImageURL
        self.friendsCount = friendsCount
        self.followersCount = followersCount
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case screenName = "screen_name"
        case description
        case profileImageURL = "profile_image_url_https"
        case profileBGImageURL = "profile_background_image_url_https"
        case friendsCount = "friends_count"
        case followersCount = "followers_count"
    }
}

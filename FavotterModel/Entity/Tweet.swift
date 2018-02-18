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
    public let media: [Media]?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
        user = try values.decode(User.self, forKey: .user)
        retweetCount = try values.decode(Int.self, forKey: .retweetCount)
        favCount = try values.decode(Int.self, forKey: .favCount)

        if let entities = try? values.nestedContainer(keyedBy: ExtendedEntitiesKeys.self, forKey: .extendedEntities) {
            media = try entities.decode([Media]?.self, forKey: .media)
        } else {
            media = nil
        }
    }
    
    public init(id: Int64, text: String, user: User, retweetCount: Int, favCount: Int, media: [Media]?) {
        self.id = id
        self.text = text
        self.user = user
        self.retweetCount = retweetCount
        self.favCount = favCount
        self.media = media
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(user, forKey: .user)
        try container.encode(retweetCount, forKey: .retweetCount)
        try container.encode(favCount, forKey: .favCount)

        var entities = container.nestedContainer(keyedBy: ExtendedEntitiesKeys.self, forKey: .extendedEntities)
        try entities.encode(media, forKey: .media)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case user
        case retweetCount = "retweet_count"
        case favCount = "favorite_count"
        case extendedEntities = "extended_entities"
    }
    
    private enum ExtendedEntitiesKeys: String, CodingKey {
        case media
    }
}

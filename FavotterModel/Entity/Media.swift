//
//  Media.swift
//  FavotterModel
//
//  Created by hirothings on 2018/02/17.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import Foundation

public struct Media: Codable {    
    public let url: String
    public let type: String
    
    private enum CodingKeys: String, CodingKey {
        case url = "media_url_https"
        case type
    }
}

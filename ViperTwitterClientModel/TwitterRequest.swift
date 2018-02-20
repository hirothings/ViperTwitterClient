//
//  TwitterRequest.swift
//  ViperTwitterClient
//
//  Created by hirothings on 2017/06/11.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation

public protocol TwitterRequest {
    associatedtype Response: Codable
    var baseURL: String { get }
    var urlString: String { get }
    var parameters: [AnyHashable: Any]? { get }
    func response(data: Data) throws -> Response
}

extension TwitterRequest {
    public var baseURL: String {
        return "https://api.twitter.com/1.1"
    }
    
    public func response(data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

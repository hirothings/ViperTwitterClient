//
//  KeyManager.swift
//  Favotter
//
//  Created by hirothings on 2018/02/12.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation

public enum KeyManagerError: Error {
    case loadFileFailed
    case parseFailed
}

public struct KeyManager {
    public var consumerKey = ""
    public var consumerSeacret = ""
    
    public init() throws {
        guard
            let dict: [String: Any] = try parsePlist("Key"),
            let consumerKey = dict["consumerKey"] as? String,
            let consumerSeacret = dict["consumerSeacret"] as? String
        else {
            throw KeyManagerError.parseFailed
        }
        self.consumerKey = consumerKey
        self.consumerSeacret = consumerSeacret
    }
    
    
    private func parsePlist(_ fileName: String) throws -> [String: Any]? {
        guard let filePath: URL = Bundle.main.url(forResource: fileName, withExtension: "plist") else {
            throw KeyManagerError.loadFileFailed
        }
        let data = try Data(contentsOf: filePath)
        return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any]
    }
}

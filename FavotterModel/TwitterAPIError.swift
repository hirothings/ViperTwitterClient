//
//  TwitterAPIError.swift
//  Favotter
//
//  Created by hirothings on 2017/06/13.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation

public enum TwitterAPIError: Error {
    case authError
    case rateLimit
    case undefindError
    
    init(error: NSError) {
        switch error.code {
        case 36, 64, 220:
            self = .authError
        case 88:
            self = .rateLimit
        default:
            self = .undefindError
        }
    }
    
    func message() -> String {
        switch self {
        case .authError:
            return "認証エラーが発生しました。ログインから再度お試しください"
        case .rateLimit:
            return "TwitterAPIのRateLimitに達しました。しばらくたってからご利用ください"
        case .undefindError:
            return "通信エラーが発生しました"
        }
    }
}

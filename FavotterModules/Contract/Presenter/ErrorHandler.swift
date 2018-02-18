//
//  ErrorHandler.swift
//  FavotterModules
//
//  Created by hirothings on 2018/02/17.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import Foundation
import FavotterModel

protocol ErrorHandler {
    func handleErrorMessage(error: Error) -> String
}

extension ErrorHandler {
    func handleErrorMessage(error: Error) -> String {
        switch error {
        case let twError as TwitterAPIError:
            return twError.message()
        default:
            return error.localizedDescription
        }

    }
}

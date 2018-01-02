//
//  UserTimelineInteractor.swift
//  Favotter
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import Foundation

protocol UserTimelineUsecase: class {
    weak var output: UserTimelineInteractorOutput! { get }
}

protocol UserTimelineInteractorOutput: class {
}

class UserTimelineInteractor: UserTimelineUsecase {
    weak var output: UserTimelineInteractorOutput!
}

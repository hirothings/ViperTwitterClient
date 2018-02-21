//
//  __PREFIX__Interactor.swift
//  ViperTwitterClient
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import Foundation

protocol __PREFIX__Usecase: class {
    var output: __PREFIX__InteractorOutput! { get }
}

protocol __PREFIX__InteractorOutput: class {
}

class __PREFIX__Interactor: __PREFIX__Usecase {
    weak var output: __PREFIX__InteractorOutput!
}

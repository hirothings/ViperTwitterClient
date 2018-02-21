//
//  __PREFIX__Presenter.swift
//  ViperTwitterClient
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import Foundation

protocol __PREFIX__Presentation {
    init(
        view: __PREFIX__View,
        router: __PREFIX__Wireframe,
        interactor: __PREFIX__Usecase
    )

    func viewDidLoad()
}

class __PREFIX__Presenter: __PREFIX__Presentation {
    private weak var view: __PREFIX__View?
    private let router: __PREFIX__Wireframe
    private let interactor: __PREFIX__Usecase

    required init(
        view: __PREFIX__View,
        router: __PREFIX__Wireframe,
        interactor: __PREFIX__Usecase
        ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad() {

    }
}

extension __PREFIX__Presenter: __PREFIX__InteractorOutput {

}

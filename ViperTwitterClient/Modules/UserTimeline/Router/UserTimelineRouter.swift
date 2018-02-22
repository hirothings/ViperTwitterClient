//
//  UserTimelineRouter.swift
//  ViperTwitterClient
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import UIKit
import ViperTwitterClientModel

protocol UserTimelineWireframe: class {
    var viewController: UIViewController? { get set }

    init(viewController: UIViewController)

    static func assembleModule(user: User) -> UIViewController
}


class UserTimelineRouter: UserTimelineWireframe {
    weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModule(user: User) -> UIViewController {
        let view = StoryboardScene.UserTimelineViewController.initialScene.instantiate()
        let interactor = UserTimelineInteractor()
        let router = UserTimelineRouter(viewController: view)

        let presenter = UserTimelinePresenter(view: view, router: router, interactor: interactor)

        view.presenter = presenter
        view.user = user
        interactor.output = presenter

        return view
    }
}

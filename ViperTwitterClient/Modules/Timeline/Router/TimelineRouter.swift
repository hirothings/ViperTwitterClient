//
//  TimelineRouter.swift
//  ViperTwitterClientView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit

protocol TimelineWireframe: class {
    var viewController: UIViewController? { get set }

    init(viewController: UIViewController?)

    func pushUserProfileView(_ user: User)
    static func assembleModule(userID: String) -> UIViewController
}

class TimelineRouter: TimelineWireframe {
    weak var viewController: UIViewController?

    required init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    // memo: ここでモック化できる
    static func assembleModule(userID: String) -> UIViewController {
        let view = StoryboardScene.TimelineViewController.initialScene.instantiate()
        let interactor = TimelineInteractor()
        let router = TimelineRouter(viewController: view)

        // memo: Presenterは依存関係が多いので、イニシャライザで参照渡す。
        let presenter = TimelinePresenter(view: view, router: router, interactor: interactor)

        view.presenter = presenter
        interactor.output = presenter

        let nav = UINavigationController(rootViewController: view)
        return nav
    }

    func pushUserProfileView(_ user: User) {
        let userProfileVC = UserTimelineRouter.assembleModule(user: user)
        self.viewController?.navigationController?.pushViewController(userProfileVC, animated: true)
    }
}

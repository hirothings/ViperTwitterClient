//
//  TimelineRouter.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit

protocol TimelineWireframe {
    weak var viewController: UIViewController? { get set }
    func pushUserProfileView(userID: String)
    static func assembleModule(userID: String) -> UIViewController
}

class TimelineRouter: TimelineWireframe {
    weak var viewController: UIViewController?

    // memo: ここでモック化できる
    static func assembleModule(userID: String) -> UIViewController {
        let bundle = Bundle(for: TimelineViewController.self)
        let storyBoard = UIStoryboard(name: "TimelineViewController", bundle: bundle)
        let view = storyBoard.instantiateInitialViewController() as! TimelineViewController
        let presenter = TimelinePresenter()
        let interactor = TimelineInteractor()
        let router = TimelineRouter()
        let nav = UINavigationController(rootViewController: view)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter

        router.viewController = view
        
        return nav
    }
    
    func pushUserProfileView(userID: String) {
        
    }
}

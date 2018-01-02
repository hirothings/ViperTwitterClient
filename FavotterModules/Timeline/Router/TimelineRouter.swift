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
    
    init(viewController: UIViewController)
    
    func pushUserProfileView(userID: String)
    static func assembleModule(userID: String) -> UIViewController
}

class TimelineRouter: TimelineWireframe {
    weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // memo: ここでモック化できる
    static func assembleModule(userID: String) -> UIViewController {
        let bundle = Bundle(for: TimelineViewController.self)
        let storyBoard = UIStoryboard(name: "TimelineViewController", bundle: bundle)
        let view = storyBoard.instantiateInitialViewController() as! TimelineViewController
        let interactor = TimelineInteractor()
        let router = TimelineRouter(viewController: view)
        
        // memo: Presenterは依存関係が多いので、イニシャライザで参照渡す。
        let presenter = TimelinePresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        
        // interactorはpresenterを参照する関係でイニシャライザで値渡しできない
        interactor.output = presenter

        let nav = UINavigationController(rootViewController: view)
        return nav
    }
    
    func pushUserProfileView(userID: String) {
        
    }
}

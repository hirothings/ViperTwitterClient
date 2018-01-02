//
//  LoginRouter.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation

protocol LoginRouterWireframe {
    weak var viewController: UIViewController? { get set }
    func pushTimelineView(userID: String)
    static func assembleModule() -> UIViewController
}

class LoginRouter: LoginRouterWireframe {
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let bundle = Bundle(for: LoginViewController.self)
        let storyBoard = UIStoryboard(name: "LoginViewController", bundle: bundle)
        let view = storyBoard.instantiateInitialViewController() as! LoginViewController
        let nav = UINavigationController(rootViewController: view)
        // TODO: Use Presenter
        
        return nav
    }
    
    func pushTimelineView(userID: String) {
    }
}

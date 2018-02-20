//
//  LoginRouter.swift
//  ViperTwitterClientView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit

protocol LoginWireframe: class {
    var viewController: UIViewController? { get set }
    
    init(viewController: UIViewController?)

    func showTimelineView(userID: String)
    static func assembleModule() -> UIViewController
}

class LoginRouter: LoginWireframe {
    var viewController: UIViewController?
    
    required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    static func assembleModule() -> UIViewController {
        let view = StoryboardScene.LoginViewController.initialScene.instantiate()
        let router = LoginRouter(viewController: view)
        let presenter = LoginPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func showTimelineView(userID: String) {
        let timelineVC = TimelineRouter.assembleModule(userID: userID)
        UIApplication.shared.keyWindow?.rootViewController = timelineVC
    }
}

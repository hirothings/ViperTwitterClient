//
//  RootRouter.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation
import TwitterKit

protocol RootWireframe: class {
    func showRootScreen()
}

public class RootRouter: RootWireframe {
    private let window: UIWindow
    private let store = TWTRTwitter.sharedInstance().sessionStore

    public init(window: UIWindow) {
        self.window = window
    }
    
    public func showRootScreen() {
        if let userID = store.session()?.userID {
            let initVC = TimelineRouter.assembleModule(userID: userID)
            window.rootViewController = initVC
            window.makeKeyAndVisible()
        } else {
            let initVC = LoginRouter.assembleModule()
            window.rootViewController = initVC
            window.makeKeyAndVisible()
        }
    }
}

//
//  AppDelegate.swift
//  Favotter
//
//  Created by hirothings on 2017/12/19.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import TwitterKit
import FavotterModules

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        TWTRTwitter.sharedInstance().start(withConsumerKey: "OIJZqrAxKlUSfx8pWtLZOOWua", consumerSecret: "NGkhWlHDGJmE3WvH96ma4W9807XD4H5g0gYsvEI4QcWEUx3kgx")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let router = RootRouter(window: self.window!)
        router.showRootScreen()
        return true
    }
}

//
//  AppDelegate.swift
//  Favotter
//
//  Created by hirothings on 2017/12/19.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        TWTRTwitter.sharedInstance().start(withConsumerKey:"OIJZqrAxKlUSfx8pWtLZOOWua", consumerSecret:"NGkhWlHDGJmE3WvH96ma4W9807XD4H5g0gYsvEI4QcWEUx3kgx")

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
}


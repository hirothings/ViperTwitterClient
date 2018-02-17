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
import FavotterUtill

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        do {
            let key = try KeyManager()
            TWTRTwitter.sharedInstance().start(
                withConsumerKey: key.consumerKey,
                consumerSecret: key.consumerSeacret
            )
        } catch KeyManagerError.loadFileFailed {
            assertionFailure("Failed to load key.plist")
        } catch KeyManagerError.parseFailed {
            assertionFailure("Failed to parse key.plist")
        } catch {
            assertionFailure()
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let router = RootRouter(window: self.window!)
        router.showRootScreen()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
}

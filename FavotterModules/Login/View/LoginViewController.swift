//
//  LoginViewController.swift
//  Favotter
//
//  Created by hirothings on 2017/12/19.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = TWTRLogInButton { (session, error) in
            guard let session = session else {
                print(error)
                return
            }
            let timelineVC = TimelineRouter.assembleModule(userID: session.userID)
            let nvc = UINavigationController(rootViewController: timelineVC)
            self.present(nvc, animated: true, completion: nil)
        }
        
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
}

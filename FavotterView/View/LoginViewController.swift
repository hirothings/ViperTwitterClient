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
        let loginButton = TWTRLogInButton { [weak self] (session: TWTRSession?, error: Error?) in
            guard let `self` = self else { return }
            if let error = error {
                let nsError = error as NSError
                if nsError.code == 1 { return }
                // TODO: Use Router
//                self.showError(error: TwitterAPIError(error: nsError))
            }
            else {
                // TODO: Use Router
                let timelineVC = self.storyboard!.instantiateViewController(withIdentifier: "TimeLineViewController")
                let nvc = UINavigationController(rootViewController: timelineVC)
                self.present(nvc, animated: true, completion: nil)
            }
        }
        
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
}


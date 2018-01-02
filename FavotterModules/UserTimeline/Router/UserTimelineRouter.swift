//
//  UserTimelineRouter.swift
//  Favotter
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import UIKit

protocol UserTimelineWireframe {
    weak var viewController: UIViewController? { get set }
    
    init(viewController: UIViewController)

    static func assembleModule(userID: String) -> UIViewController
}


class UserTimelineRouter: UserTimelineWireframe {
    weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModule(userID: String) -> UIViewController {
        
    }
}

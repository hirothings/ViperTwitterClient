//
//  __PREFIX__Router.swift
//  ViperTwitterClient
//
//  Created by __USERNAME__ on __DATE__.
//  Copyright © __YEAR__ __USERNAME__. All rights reserved.
//

import UIKit

protocol __PREFIX__Wireframe {
    var viewController: UIViewController? { get set }

    init(viewController: UIViewController)
}


class __PREFIX__Router: __PREFIX__Wireframe {
    weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

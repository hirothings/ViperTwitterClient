//
//  TimelineRouter.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit

protocol TimelineWireframe {
    weak var viewController: UIViewController? { get set }
    func pushDetailView(userID: String)
}

class TimelineRouter: TimelineWireframe {
    weak var viewController: UIViewController?

    func pushDetailView(userID: String) {
    }
}

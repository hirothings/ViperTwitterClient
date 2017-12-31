//
//  TweetsRouter.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit

protocol TweetsWireFrame {
    weak var viewController: UIViewController { get set }
    func pushDetailView(userID: String)
}

class TweetsRouter: TweetsWireFrame {
    
}
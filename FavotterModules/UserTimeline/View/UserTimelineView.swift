//
//  UserTimelineViewController.swift
//  Favotter
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import UIKit

protocol UserTimelineView: class {}

class UserTimelineViewController: UIViewController {
    var presenter: UserTimelinePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UserTimelineViewController: UserTimelineView {
    
}

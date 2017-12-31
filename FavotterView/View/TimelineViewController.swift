//
//  TimelineViewController.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit

protocol TimelineView: class {
    var presenter: TimelinePresenter! { get set }
    func showNoContentView()
    func showTimeline()
}

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TimelinePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension TimelineViewController: TimelineView {
    func showNoContentView() {
    }
    
    func showTimeline() {
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension TimelineViewController: UITableViewDelegate {
    
}

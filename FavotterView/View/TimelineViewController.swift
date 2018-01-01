//
//  TimelineViewController.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import FavotterAPIClient

protocol TimelineView: class {
    var presenter: TimelinePresenter! { get set }
    func showNoContentView()
    func showTimeline(tweets: [Tweet])
}

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TimelinePresenter!
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    private func setupView() {
        self.navigationItem.title = "タイムライン"
        
        let bundle = Bundle(for: TimelineViewController.self)
        let nib = UINib(nibName: "TweetTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: "TweetTableViewCell")
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TimelineViewController: TimelineView {
    func showNoContentView() {
        // TODO:
    }
    
    func showTimeline(tweets: [Tweet]) {
        self.tweets = tweets
        tableView.reloadData()
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        cell.tweet = self.tweets[indexPath.row]
        return cell
    }
}

extension TimelineViewController: UITableViewDelegate {
    
}

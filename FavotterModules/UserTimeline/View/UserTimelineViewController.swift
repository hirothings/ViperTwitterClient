//
//  UserTimelineViewController.swift
//  Favotter
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import UIKit
import FavotterModel

protocol UserTimelineView: class {
    func showNoContentView()
    func showTimeline(tweets: [Tweet])
}

class UserTimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: UserTimelinePresenter!
    var tweets: [Tweet] = []
    var user: User! {
        didSet {
            self.navigationItem.title = user.name
            presenter.fetchUserTimeline(user: user)
        }
    }

    // TODO: Use Enumrable Enum
    private let sectionCount: Int = 2
    
    enum Section: Int {
        case profile
        case timeline
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let bundle = Bundle(for: UserTimelineViewController.self)
        let profNib = UINib(nibName: "ProfileTableViewCell", bundle: bundle)
        let twNib = UINib(nibName: "TweetTableViewCell", bundle: bundle)
        tableView.register(profNib, forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(twNib, forCellReuseIdentifier: "TweetTableViewCell")
        tableView.estimatedRowHeight =  85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension UserTimelineViewController: UserTimelineView {
    func showNoContentView() {
    }
    
    func showTimeline(tweets: [Tweet]) {
        self.tweets = tweets
        tableView.reloadData()
    }
}

extension UserTimelineViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)!
        
        switch section {
        case .profile:
            return 1
        case .timeline:
            return tweets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)!
        
        switch section {
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.user = self.user
            return cell
        case .timeline:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
            cell.tweet = self.tweets[indexPath.row]
            return cell
        }
    }
}

extension UserTimelineViewController: UITableViewDelegate {
    
}

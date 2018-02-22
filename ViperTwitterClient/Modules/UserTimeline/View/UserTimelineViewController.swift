//
//  UserTimelineViewController.swift
//  ViperTwitterClient
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import UIKit
import ViperTwitterClientModel
import RxSwift

class UserTimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    weak var presenter: UserTimelinePresenter!
    var tweets: [Tweet] = []
    var user: User! {
        didSet {
            self.navigationItem.title = user.name
            presenter.fetchUserTimeline(user: user)
        }
    }

    private let sectionCount: Int = 2
    private let bag = DisposeBag()

    enum Section: Int {
        case profile
        case timeline
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }

    private func setupView() {
        tableView.register(cellType: TweetTableViewCell.self)
        tableView.register(cellType: ProfileTableViewCell.self)
        tableView.estimatedRowHeight =  85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    private func setupRx() {
        tableView.rx.reachedBottom
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.presenter.reachedBottom(user: weakSelf.user)
            })
            .disposed(by: bag)
    }
}

extension UserTimelineViewController: TimelineView {
    func showNoContentView() {
    }

    func showTimeline(tweets: [Tweet]) {
        self.tweets = tweets
        tableView.reloadData()
    }

    func updateTimeline(tweets: [Tweet]) {
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
            let cell: ProfileTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupProfile(with: user)
            return cell
        case .timeline:
            let cell: TweetTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupTweet(tweets[indexPath.row])
            return cell
        }
    }
}

extension UserTimelineViewController: UITableViewDelegate {

}

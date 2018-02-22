//
//  TimelineViewController.swift
//  ViperTwitterClientView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ViperTwitterClientModel
import ViperTwitterClientUtill

protocol TimelineView: ErrorableView {
    func showNoContentView()
    func showTimeline(tweets: [Tweet])
    func updateTimeline(tweets: [Tweet])
}

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!

    weak var presenter: TimelinePresentation!
    var tweets: [Tweet] = []

    private let refreshControl = UIRefreshControl()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
        presenter.viewDidLoad()
    }

    private func setupView() {
        self.navigationItem.title = "タイムライン"

        tableView.register(cellType: TweetTableViewCell.self)
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        noDataLabel.isHidden = true
    }

    private func setupRx() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in self?.presenter.pullToRefresh() })
            .disposed(by: bag)

        tableView.rx.reachedBottom
            .asObservable()
            .subscribe(onNext: { [weak self] _ in self?.presenter.reachedBottom() })
            .disposed(by: bag)
    }
}

extension TimelineViewController: TimelineView {
    func showNoContentView() {
        refreshControl.endRefreshing()
        noDataLabel.isHidden = false
    }

    func showTimeline(tweets: [Tweet]) {
        self.tweets = tweets
        noDataLabel.isHidden = true
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func updateTimeline(tweets: [Tweet]) {
        self.tweets = tweets
        tableView.reloadData()
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TweetTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupTweet(tweets[indexPath.row])
        return cell
    }
}

extension TimelineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tweet = tweets[indexPath.row]
        self.presenter.didSelectTweet(with: tweet.user)
    }
}

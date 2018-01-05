//
//  TimelineViewController.swift
//  FavotterView
//
//  Created by hirothings on 2017/12/31.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FavotterModel

protocol TimelineView: class {
    var presenter: TimelinePresenter! { get set }
    func showNoContentView()
    func showTimeline(tweets: [Tweet])
}

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TimelinePresenter!
    var tweets: [Tweet] = []
    
    private let refreshControl = UIRefreshControl()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    private func setupView() {
        self.navigationItem.title = "タイムライン"
        
        tableView.register(xib: TweetTableViewCell.Xib.self)
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in self?.presenter.pullToRefresh() })
            .disposed(by: bag)
    }
}

extension TimelineViewController: TimelineView {
    func showNoContentView() {
        // TODO:
    }
    
    func showTimeline(tweets: [Tweet]) {
        self.tweets = tweets
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TweetTableViewCell.Xib.self, for: indexPath)
        cell.tweet = self.tweets[indexPath.row]
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

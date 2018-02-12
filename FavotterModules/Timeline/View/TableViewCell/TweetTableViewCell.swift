//
//  TweetTableViewCell.swift
//  Favotter
//
//  Created by hirothings on 2017/06/12.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import RxSwift
import Nuke
import FavotterModel
import Reusable

class TweetTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var fabCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetLabel.numberOfLines = 0
        tweetLabel.sizeToFit()
        tweetLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupTweet(_ tweet: Tweet) {
        if let url = URL(string: tweet.user.profileImageURL) {
            Manager.shared.loadImage(with: url, into: profileImageView)
        }
        nameLabel.text = tweet.user.name
        screenNameLabel.text = "@\(tweet.user.screenName)"
        tweetLabel.text = tweet.text
        retweetCount.text = "\(tweet.retweetCount)"
        fabCount.text = "\(tweet.favCount)"
    }
}

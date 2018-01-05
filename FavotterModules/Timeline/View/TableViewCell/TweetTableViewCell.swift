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

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var fabCount: UILabel!
    
    // TODO: Force Unwrap以外の手段ないか？delayかdefferか..
    var tweet: Tweet! {
        didSet {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetLabel.numberOfLines = 0
        tweetLabel.sizeToFit()
        tweetLabel.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

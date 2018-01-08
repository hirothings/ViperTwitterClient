//
//  ProfileTableViewCell.swift
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

class ProfileTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var profileBGImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    var user: User! {
        didSet {
            if let url = URL(string: user.profileImageURL) {
                Manager.shared.loadImage(with: url, into: profileImageView)
            }
            if let urlStr = user.profileBGImageURL, let url = URL(string: urlStr) {
                Manager.shared.loadImage(with: url, into: profileBGImageView)
            }
            nameLabel.text = user.name
            screenNameLabel.text = "@\(user.screenName)"
            descriptionLabel.text = user.description
            friendsCountLabel.text = "\(user.friendsCount) フォロー"
            followerCountLabel.text = "\(user.followersCount) フォロワー"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        descriptionLabel.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

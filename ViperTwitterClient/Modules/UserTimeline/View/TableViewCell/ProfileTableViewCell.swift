//
//  ProfileTableViewCell.swift
//  ViperTwitterClient
//
//  Created by hirothings on 2017/06/12.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import RxSwift
import Nuke
import Reusable

class ProfileTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var profileBGImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupProfile(with user: User) {
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

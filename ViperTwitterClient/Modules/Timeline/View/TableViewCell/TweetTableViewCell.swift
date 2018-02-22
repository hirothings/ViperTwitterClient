//
//  TweetTableViewCell.swift
//  ViperTwitterClient
//
//  Created by hirothings on 2017/06/12.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import UIKit
import RxSwift
import Nuke
import Reusable

class TweetTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var fabCount: UILabel!
    @IBOutlet weak var tweetImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetLabel.numberOfLines = 0
        tweetLabel.sizeToFit()
        tweetLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupTweet(_ tweet: Tweet) {
        if let url = URL(string: tweet.user.profileImageURL) {
            Manager.shared.loadImage(with: url, into: profileImageView)
        } else {
            profileImageView.image = nil
        }
        if let urlStr = tweet.media?.first?.url, let url = URL(string: urlStr) {
            Manager.shared.loadImage(with: url, into: tweetImageVIew, handler: { [weak self] (image: Result<UIImage>, _) in
                guard let weakSelf = self, let image = image.value else { return }
                weakSelf.tweetImageVIew.image = weakSelf.cropImage(
                    image: image,
                    width: weakSelf.tweetImageVIew.frame.width,
                    height: weakSelf.tweetImageVIew.frame.width / 2
                )
            })
        } else {
            tweetImageVIew.image = nil
        }
        nameLabel.text = tweet.user.name
        screenNameLabel.text = "@\(tweet.user.screenName)"
        tweetLabel.text = tweet.text
        retweetCount.text = "\(tweet.retweetCount)"
        fabCount.text = "\(tweet.favCount)"
    }
    
    private func cropImage(image: UIImage, width w: CGFloat, height h: CGFloat) -> UIImage {
        let originRef = image.cgImage
        let originWidth = CGFloat(originRef!.width)
        let originHeight = CGFloat(originRef!.height)
        var resizeWidth: CGFloat
        var resizeHeight: CGFloat
        
        resizeWidth = w
        resizeHeight = originHeight * resizeWidth / originWidth
        
        let resizeSize = CGSize(width: resizeWidth, height: resizeHeight)
        UIGraphicsBeginImageContext(resizeSize)
        
        image.draw(in: CGRect(x: 0, y: 0, width: resizeWidth, height: resizeHeight))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cropRect = CGRect(x: (resizeWidth - w) / 2,
                              y: (resizeHeight - h) / 2,
                              width: w, height: h)
        let cropRef = resizeImage!.cgImage!.cropping(to: cropRect)
        return UIImage(cgImage: cropRef!)
    }
}

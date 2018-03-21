//
//  TweetCell.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

final class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!

    static let estimatedRowHeight: CGFloat = 88.0
    
    static var identifier: String {
        return String(describing: self)
    }

    var tweet: HomeTimelineTweet? {
        didSet { set(tweet: tweet) }
    }

    func set(profileImage: UIImage?) {
        profileImageView.image = profileImage
    }

    private func set(tweet: HomeTimelineTweet?) {
        userNameLabel.text = tweet?.name
        userScreenNameLabel.text = tweet?.screenName
        tweetLabel.text = tweet?.text
    }
}

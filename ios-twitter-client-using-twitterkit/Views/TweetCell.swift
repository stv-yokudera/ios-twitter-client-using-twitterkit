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
        loadImage(tweet: tweet)
    }

    private func loadImage(tweet: HomeTimelineTweet?) {
        guard let tweet = tweet else {
            return
        }

        // DBにイメージデータが保存されている場合は、それを描画する
        if let twitterProfileImage = TwitterProfileImageDao.findByID(profileId: tweet.id),
            let imageData = twitterProfileImage.imageData {
            profileImageView.image = UIImage(data: imageData)
            return
        }

        guard let profileImageUrl = URL(string: tweet.profileImageUrl) else {
            return
        }

        let urlRequest = URLRequest(url: profileImageUrl)
        let urlSessionConfig = URLSessionConfiguration.default
        urlSessionConfig.timeoutIntervalForRequest = 30.0
        urlSessionConfig.timeoutIntervalForResource = 60.0

        let urlSession = URLSession(configuration: urlSessionConfig)

        urlSession.dataTask(with: urlRequest) { [weak self] data, _, error in

            if let error = error {
                print("Failed to download image.\n\(error.localizedDescription)")
                return
            }

            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                self?.profileImageView.image = UIImage(data: data)
                let downloadedProfileImage = TwitterProfileImage()
                downloadedProfileImage.profileId = tweet.id
                downloadedProfileImage.imageData = data
                TwitterProfileImageDao.add(model: downloadedProfileImage)
            }
        }.resume()
    }
}

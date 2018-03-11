//
//  HomeTimelineProvider.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

final class HomeTimelineProvider: NSObject {

    private var tweets = [HomeTimelineTweet]()

    func set(tweets: [HomeTimelineTweet]) {
        self.tweets = tweets
    }
}

extension HomeTimelineProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TweetCell.identifier,
            for: indexPath) as? TweetCell else {

                fatalError("TweetCell is nil.")
        }
        cell.set(profileImage: nil)
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

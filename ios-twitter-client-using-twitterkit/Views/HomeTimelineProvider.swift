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
    private var tasks = [URLSessionTask]()

    func set(tweets: [HomeTimelineTweet]) {
        self.tweets = tweets
    }

    /// プロフィールイメージをダウンロードする
    private func downloadProfileImage(forItemAtIndex index: Int, completion: (() -> Void)? = nil) {

        let urlString = tweets[index].profileImageUrl
        guard let profileImageUrl = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: profileImageUrl) { data, _, error in
            if let error = error {
                print("Failed to download image.\n\(error.localizedDescription)")
                return
            }

            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                let downloadedProfileImage = TwitterProfileImage()
                downloadedProfileImage.profileId = self.tweets[index].id
                downloadedProfileImage.imageData = data
                TwitterProfileImageDao.add(model: downloadedProfileImage)
                completion?()
            }
        }
        task.resume()
        tasks.append(task)
    }

    /// プロフィールイメージのダウンロードをキャンセルする
    private func cancelDownloadingImage(forItemAtIndex index: Int) {
        let urlString = tweets[index].profileImageUrl
        guard let profileImageUrl = URL(string: urlString) else {
            return
        }
        guard let taskIndex = tasks.index(where: { $0.originalRequest?.url == profileImageUrl } ) else {
            return
        }
        let task = tasks[taskIndex]
        task.cancel()
        tasks.remove(at: taskIndex)
    }

    /// DBからプロフィール画像を取得する
    ///
    /// プロフィール画像が保存されていない場合は、nilを返す
    private func loadImageFromDB(tweet: HomeTimelineTweet) -> UIImage? {
        if let twitterProfileImage = TwitterProfileImageDao.findByID(profileId: tweet.id),
            let imageData = twitterProfileImage.imageData {
            return UIImage(data: imageData)
        }
        return nil
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
        cell.tweet = tweets[indexPath.row]

        cell.set(profileImage: nil)
        if let image = loadImageFromDB(tweet: tweets[indexPath.row]) {
            cell.set(profileImage: image)
            return cell
        }
        // DBにイメージデータが保存されていない場合は、ダウンロードする
        downloadProfileImage(forItemAtIndex: indexPath.row) {
            if let image = self.loadImageFromDB(tweet: self.tweets[indexPath.row]) {
                cell.set(profileImage: image)
            }
        }
        return cell
    }
}

extension HomeTimelineProvider: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            downloadProfileImage(forItemAtIndex: $0.row)
        }
    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            cancelDownloadingImage(forItemAtIndex: $0.row)
        }
    }
}

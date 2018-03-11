//
//  HomeTimelineTweet.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import ObjectMapper

/// ホームタイムライン取得APIレスポンス
final class HomeTimelineTweet: Mappable {

    /// ID
    var id = ""
    /// ユーザ名
    var name = ""
    /// スクリーン名
    var screenName = ""
    /// サムネイル画像のURL
    var profileImageUrl = ""
    /// ツイート文言
    var text = ""

    var description: String {
        return """
        ~~~~~
        id: \(id)
        name: \(name)
        screenName: \(screenName)
        profileImageUrl: \(profileImageUrl)
        text: \(text)
        """
    }

    init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id_str"]
        name <- map["user.name"]
        screenName <- map["user.screen_name"]
        profileImageUrl <- map["user.profile_image_url_https"]
        text <- map["text"]
    }
}

//
//  DummyResponse.swift
//  ios-twitter-client-using-twitterkitTests
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

final class DummyResponse {

    /// ホームタイムライン取得APIのダミーレスポンス
    static let homeTimeline: [String : Any] = [
        "id_str": "240558470661799936",
        "text": "just another test",
        "user": [
            "name": "OAuth Dancer",
            "profile_image_url_https": "https://si0.twimg.com/profile_images/730275945/oauth-dancer_normal.jpg",
            "screen_name": "oauth_dancer"
        ]
    ]
}

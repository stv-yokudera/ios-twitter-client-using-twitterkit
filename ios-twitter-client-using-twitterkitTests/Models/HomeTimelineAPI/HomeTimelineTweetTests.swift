//
//  HomeTimelineTweetTests.swift
//  ios-twitter-client-using-twitterkitTests
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@testable import ios_twitter_client_using_twitterkit
import ObjectMapper
import XCTest

final class HomeTimelineTweetTests: XCTestCase {
    
    /// ホームタイムライン取得APIレスポンスをマッピングするテスト
    func testHomeTimelineTweetMapping() {

        let tweet = Mapper<HomeTimelineTweet>().map(JSON: DummyResponse.homeTimeline)
        XCTAssertEqual(tweet?.id, "240558470661799936")
        XCTAssertEqual(tweet?.name, "OAuth Dancer")
        XCTAssertEqual(tweet?.screenName, "oauth_dancer")
        XCTAssertEqual(tweet?.profileImageUrl, "https://si0.twimg.com/profile_images/730275945/oauth-dancer_normal.jpg")
        XCTAssertEqual(tweet?.text, "just another test")
    }
}

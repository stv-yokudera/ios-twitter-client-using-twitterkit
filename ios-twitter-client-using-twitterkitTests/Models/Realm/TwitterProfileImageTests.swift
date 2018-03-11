//
//  TwitterProfileImageTests.swift
//  ios-twitter-client-using-twitterkitTests
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@testable import ios_twitter_client_using_twitterkit
import XCTest

final class TwitterProfileImageTests: XCTestCase {
    
    /// 初期化のテスト
    func testInit() {
        let twitterProfileImage = TwitterProfileImage()

        // Verify
        XCTAssertEqual(twitterProfileImage.profileId, "")
        XCTAssertEqual(twitterProfileImage.imageData, nil)
    }

    /// プライマリキーを確認するテスト
    func testPrimaryKey() {
        // Verify
        XCTAssertEqual(TwitterProfileImage.primaryKey(), "profileId")
    }
}

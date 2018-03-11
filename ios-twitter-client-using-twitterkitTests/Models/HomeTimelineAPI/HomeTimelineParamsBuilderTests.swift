//
//  HomeTimelineParamsBuilderTests.swift
//  ios-twitter-client-using-twitterkitTests
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@testable import ios_twitter_client_using_twitterkit
import XCTest

final class HomeTimelineParamsBuilderTests: XCTestCase {

    /// ホームタイムライン取得APIのリクエストパラメータを生成するテスト
    func testBuild() {
        let params = HomeTimelineParamsBuilder.build()
        XCTAssertEqual(params["count"], "20")
        XCTAssertEqual(params["trim_user"], "false")
    }
}

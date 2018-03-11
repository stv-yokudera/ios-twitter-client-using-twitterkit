//
//  AlertHelperTests.swift
//  ios-twitter-client-using-twitterkitTests
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@testable import ios_twitter_client_using_twitterkit
import XCTest

final class AlertHelperTests: XCTestCase {

    /// ボタン1つのアラートを生成する処理をテスト
    func testBuildSingleButtonAlert() {

        let alert = AlertHelper.buildAlert(message: "メッセージ")
        XCTAssertEqual(alert.title, "")
        XCTAssertEqual(alert.message, "メッセージ")
        XCTAssertEqual(alert.actions.count, 1)
        XCTAssertEqual(alert.actions.first?.title, "OK")
        XCTAssertEqual(alert.actions.first?.style, .default)
    }

    /// ボタン2つのアラートを生成する処理をテスト
    func testBuildAlert() {

        let alert = AlertHelper.buildAlert(title: "タイトル",
                                           message: "メッセージ",
                                           rightButtonTitle: "OK",
                                           leftButtonTitle: "Cancel",
                                           rightButtonAction: nil,
                                           leftButtonAction: nil)
        XCTAssertEqual(alert.title, "タイトル")
        XCTAssertEqual(alert.message, "メッセージ")
        XCTAssertEqual(alert.actions.count, 2)
        XCTAssertEqual(alert.actions[0].title, "OK")
        XCTAssertEqual(alert.actions[0].style, .default)
        XCTAssertEqual(alert.actions[1].title, "Cancel")
        XCTAssertEqual(alert.actions[1].style, .cancel)
    }
}

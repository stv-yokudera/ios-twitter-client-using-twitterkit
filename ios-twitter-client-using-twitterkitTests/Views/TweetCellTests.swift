//
//  TweetCellTests.swift
//  ios-twitter-client-using-twitterkitTests
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@testable import ios_twitter_client_using_twitterkit
import ObjectMapper
import XCTest

final class TweetCellTests: XCTestCase {
    
    let dataSource = FakeDataSource()
    var tableView: UITableView!
    var cell: TweetCell!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "HomeTimelineViewController", bundle: nil)
        guard let homeTimelineVC = storyboard.instantiateViewController(
            withIdentifier: "HomeTimelineViewController") as? HomeTimelineViewController else {
                XCTFail("HomeTimelineViewControllerのインスタンス生成失敗")
                return
        }
        homeTimelineVC.loadView()

        tableView = homeTimelineVC.tableView
        tableView.dataSource = dataSource

        cell = tableView?.dequeueReusableCell(withIdentifier: TweetCell.identifier,
                                              for: IndexPath(row: 0, section: 0)) as! TweetCell
    }

    /// HomeTimelineCell上のラベルの文言を確認するテスト
    func testSetTweet() {
        let tweet = Mapper<HomeTimelineTweet>().map(JSON: DummyResponse.homeTimeline)
        cell.tweet = tweet
        
        XCTAssertEqual(cell.userNameLabel.text, "OAuth Dancer")
        XCTAssertEqual(cell.userScreenNameLabel.text, "oauth_dancer")
        XCTAssertEqual(cell.tweetLabel.text, "just another test")
    }
}

extension TweetCellTests {

    final class FakeDataSource: NSObject, UITableViewDataSource {

        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}

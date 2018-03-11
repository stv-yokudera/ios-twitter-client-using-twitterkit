//
//  TwitterProfileImageDaoTests.swift
//  ios-twitter-client-using-twitterkitTests
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

@testable import ios_twitter_client_using_twitterkit
import XCTest

final class TwitterProfileImageDaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        UTRealm.removeUTDirectory()
    }
    
    override func tearDown() {
        UTRealm.removeUTDirectory()
        super.tearDown()
    }
    
    /// プロフィール画像を登録する処理と取得する処理のテスト
    func testAddAndFind() {

        TwitterProfileImageDao.add(model: dummyModel())
        let addedModel = TwitterProfileImageDao.findByID(profileId: "240558470661799936")

        XCTAssertNotNil(addedModel)
        XCTAssertEqual(addedModel?.profileId, "240558470661799936")
        XCTAssertEqual(addedModel?.imageData, Data())
    }

    // MARK: - private

    /// TwitterIconImageのダミー
    private func dummyModel() -> TwitterProfileImage {
        let model = TwitterProfileImage()
        model.profileId = "240558470661799936"
        model.imageData = Data()

        return model
    }
}

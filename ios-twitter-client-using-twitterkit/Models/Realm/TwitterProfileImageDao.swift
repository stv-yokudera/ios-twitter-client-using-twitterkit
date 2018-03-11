//
//  TwitterProfileImageDao.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import RealmSwift

final class TwitterProfileImageDao {

    static let dao = RealmDaoHelper<TwitterProfileImage>()

    // MARK: - find

    /// プロフィール画像を取得する
    ///
    /// - Parameter profileId: プロフィールID
    /// - Returns: プロフィール画像の情報
    static func findByID(profileId: String) -> TwitterProfileImage? {
        guard let object = dao.findFirst(key: profileId as AnyObject) else { return nil }
        return TwitterProfileImage(value: object)
    }

    // MARK: - add

    /// プロフィール画像を登録する
    ///
    /// - Parameter model: プロフィール画像の情報
    static func add(model: TwitterProfileImage) {

        // 登録済みであればreturn
        if let _ = findByID(profileId: model.profileId) { return }

        let newObject = TwitterProfileImage()
        newObject.profileId = model.profileId
        newObject.imageData = model.imageData
        dao.add(d: newObject)
    }
}

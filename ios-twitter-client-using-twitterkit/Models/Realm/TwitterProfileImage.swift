//
//  TwitterProfileImage.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation
import RealmSwift

final class TwitterProfileImage: Object {
    @objc dynamic var profileId = ""
    @objc dynamic var imageData: Data?

    override static func primaryKey() -> String? {
        return "profileId"
    }
}

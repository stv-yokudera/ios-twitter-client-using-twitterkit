//
//  Constants.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Keys
import Foundation

final class Constants: NSObject {

    enum TwitterKitKeys {

        // "TwitterKitConsumerKey"
        static var consumerKey: String {
            return IosTwitterClientUsingTwitterkitKeys().twitterKitConsumerKey
        }

        // "TwitterKitConsumerSecret"
        static var consumerSecret: String {
            return IosTwitterClientUsingTwitterkitKeys().twitterKitConsumerSecret
        }
    }
}

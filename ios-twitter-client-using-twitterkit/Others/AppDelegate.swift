//
//  AppDelegate.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/10.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import TwitterKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        TWTRTwitter.sharedInstance().start(
            withConsumerKey: Constants.TwitterKitKeys.consumerKey,
            consumerSecret: Constants.TwitterKitKeys.consumerSecret
        )

        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if TWTRTwitter.sharedInstance().application(app, open: url, options: options) {
            return true
        }

        // failed to open.
        return false
    }
}

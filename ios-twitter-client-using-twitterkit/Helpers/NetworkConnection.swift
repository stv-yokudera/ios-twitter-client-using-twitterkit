//
//  NetworkConnection.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Reachability

final class NetworkConnection {

    /// ネットワーク接続状況確認
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isReachable() -> Bool {
        guard let reachability = Reachability() else {
            return false
        }
        return reachability.connection != .none
    }
}

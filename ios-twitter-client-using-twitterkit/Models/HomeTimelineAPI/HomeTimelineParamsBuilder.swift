//
//  HomeTimelineParamsBuilder.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

final class HomeTimelineParamsBuilder {

    /// ホームタイムライン取得APIのリクエストパラメータを生成する
    ///
    /// - Parameter count: 取得するレコード数
    /// - Returns: リクエストパラメータ
    static func build(count: Int = 20) -> [String: String] {
        var params = [String: String]()
        params["count"] = count.description
        params["trim_user"] = "false"

        return params
    }
}

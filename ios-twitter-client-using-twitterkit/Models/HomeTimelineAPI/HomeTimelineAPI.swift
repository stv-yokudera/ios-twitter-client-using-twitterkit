//
//  HomeTimelineAPI.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation
import ObjectMapper
import TwitterKit

/// APIステータス
enum HomeTimelineAPIStatus {
    case loading
    case loaded([HomeTimelineTweet])
    case timeout
    case offline
    case error(message: String)
}

/// APIリクエスト結果を通知するプロトコル
protocol HomeTimelineResult: class {
    func set(status: HomeTimelineAPIStatus)
}

final class HomeTimelineAPI {

    weak var result: HomeTimelineResult?

    /// HomeTimelineAPIリクエストをする
    ///
    /// - Parameters:
    ///   - account: Twitterアカウント
    func load(userID: String?) {

        if !NetworkConnection.isReachable() {
            result?.set(status: .offline)
            return
        }

        result?.set(status: .loading)

        let parameters = HomeTimelineParamsBuilder.build()
        let client = TWTRAPIClient(userID: userID)
        let endpoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        var error: NSError?

        let request = client.urlRequest(withMethod: "GET",
                                        urlString: endpoint,
                                        parameters: parameters,
                                        error: &error)

        client.sendTwitterRequest(request) { [weak self] response, responseData, error in

            if let error = error {
                if (error as NSError).code == NSURLErrorTimedOut {
                    self?.result?.set(status: .timeout)
                }
                self?.result?.set(status: .error(message: error.localizedDescription))
                return
            }

            if
                let data = responseData,
                let jsonString = String(data: data, encoding: .utf8),
                let result = Mapper<HomeTimelineTweet>().mapArray(JSONString: jsonString) {
                self?.result?.set(status: .loaded(result))
            } else {
                self?.result?.set(status: .error(message: "FAILED_TO_GET_TIMELINE".localized()))
            }
        }
    }
}

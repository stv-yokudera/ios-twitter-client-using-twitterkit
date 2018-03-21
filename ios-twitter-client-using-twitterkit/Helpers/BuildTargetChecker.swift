//
//  BuildTargetChecker.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/21.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

final class BuildTargetChecker {

    /// XCTest実行中かどうかチェックする
    ///
    /// - Returns: true: XCTest実行中, false: XCTest実行中でない
    static func isTesting() -> Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}

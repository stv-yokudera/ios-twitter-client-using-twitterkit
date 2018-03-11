//
//  TwitterSessionStore.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation
import TwitterKit

final class TwitterSessionStore {

    // MARK: - Nested structures

    struct LoggedInUser {
        var id = ""
    }
    
    struct LogInError {
        var message = ""
    }

    // MARK: - Static functions

    /// セッションの確認
    static func loggedInUserAuthSession() -> TWTRAuthSession? {
        return TWTRTwitter.sharedInstance().sessionStore.session()
    }

    /// Twitterログイン
    ///
    /// - Parameters:
    ///   - completion: ログイン実行後の処理(ログイン成功時はuserIDが返却される)
    static func login(completion: @escaping (LoggedInUser?, LogInError?) -> Void) {
        TWTRTwitter.sharedInstance().logIn { session, error in

            if let error = error {
                print(error.localizedDescription)
                completion(nil, LogInError(message: error.localizedDescription))
                return
            }

            guard let session = session else {
                completion(nil, LogInError(message: "SESSION_IS_NIL".localized()))
                return
            }
            completion(LoggedInUser(id: session.userID), nil)
        }
    }
}

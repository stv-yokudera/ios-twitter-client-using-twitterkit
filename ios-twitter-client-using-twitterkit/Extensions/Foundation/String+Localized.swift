//
//  String+Localized.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

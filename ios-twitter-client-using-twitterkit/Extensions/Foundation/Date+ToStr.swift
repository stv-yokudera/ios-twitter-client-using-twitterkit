//
//  Date+ToStr.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

extension Date {

    /// Date型をString型に変更する
    func toStr(dateFormat: String) -> String  {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = dateFormat

        return dateFormatter.string(from: self)
    }
}

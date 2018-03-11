//
//  String+Path.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

extension String {

    private var nsString: NSString {
        return (self as NSString)
    }
    
    func appendingPathComponent(_ str: String) -> String {
        return nsString.appendingPathComponent(str)
    }
}

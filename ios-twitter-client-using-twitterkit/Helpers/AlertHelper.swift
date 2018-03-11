//
//  AlertHelper.swift
//  ios-twitter-client-using-twitterkit
//
//  Created by OkuderaYuki on 2018/03/11.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

final class AlertHelper {

    static func buildAlert(title: String = "",
                           message: String,
                           rightButtonTitle: String = "ALERT_OK".localized(),
                           leftButtonTitle: String? = nil,
                           rightButtonAction: ((UIAlertAction) -> Void)? = nil,
                           leftButtonAction: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let positiveAction = UIAlertAction(title: rightButtonTitle, style: .default, handler: rightButtonAction)
        alert.addAction(positiveAction)

        if let leftButtonTitle = leftButtonTitle {
            let negativeAction = UIAlertAction(title: leftButtonTitle, style: .cancel, handler: leftButtonAction)
            alert.addAction(negativeAction)
        }
        return alert
    }
}

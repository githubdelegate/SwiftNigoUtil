//
//  UIApplication+Util.swift
//  cleaner
//
//  Created by zy on 2020/9/4.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation
import UIKit

public extension UIApplication {
    /// 跳转到设置页面
    class func gotoSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    class func gotoReward(appId: String) {
        if appId.isEmpty { return }
        DispatchQueue.main.async {
            let s = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" + appId
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: s)!, options: [:], completionHandler: nil)
            } else {
                
            }
        }
    }
    
    
    class func appName() -> String {
           guard let dictionary = Bundle.main.infoDictionary else {
               return ""
           }
           if let name : String = dictionary["CFBundleName"] as? String {
               return name
           } else {
               return ""
           }
    }
    
    class func version() -> String {
           guard let dictionary = Bundle.main.infoDictionary else {
               return ""
           }
           if let version : String = dictionary["CFBundleShortVersionString"] as? String {
               return version
           } else {
               return ""
           }
    }
}

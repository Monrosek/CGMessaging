//
//  Alerts.swift
//  CGMessaging
//
//  Created by Mac on 12/2/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class Alert {
    class func Send(_ show:UIViewController, _ text:String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        show.present(alert, animated: true, completion: nil)
    }
    
    class func Show(_ _title:String,_ _message:String,_ action:String?) {
        let alertController = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        //...
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if action != nil {
            alertController.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
        }
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

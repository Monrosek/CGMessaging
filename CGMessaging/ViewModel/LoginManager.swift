//
//  LoginManager.swift
//  CGMessaging
//
//  Created by Mac on 12/3/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import SwiftKeychainWrapper
import LocalAuthentication

enum FieldType {
    case Email
    case Password
}


class LoginManager {
    static let shared = LoginManager()
    var user:User?
    var isLoggedIn:Bool {
        get {return user != nil}
    }
    let sharedAuth = Auth.auth()
    init() {
        sharedAuth.addStateDidChangeListener{ (auth,user) in
            guard let user = user else {return}
            guard let email = user.email else {return}
            self.user = User(email: email, uid: user.uid)
            
        }
    }
    
    class func Login(email:String, pass:String, completionHandler:@escaping(Bool?)->()) {
   
        self.shared.sharedAuth.signIn(withEmail: email, password: pass){
            (user, error) in
            guard error == nil else {
                Alert.Show("Error", error!.localizedDescription, "OK")
             return
            }
            guard let user = user else {return}
            guard let email = user.email else {return}

            self.shared.user = User(email: email, uid: user.uid)
            
            //User Defaults
            let userDefault = UserDefaults.standard
            //Saving Username to UserDefaults on device
            userDefault.set(email, forKey: Constants.keys.UserName)
            //disable after testing
            userDefault.set(pass, forKey: Constants.keys.Password)

            //Ask user if they want to use touch ID
            //UIAlertController
            //Check for his fingerprint is in the system
            KeychainWrapper.standard.set(pass, forKey: Constants.keys.Password)
            completionHandler(true)
        }
    }
    
    static func Evaluate(_ text:String,_ type:FieldType) -> Bool {
        var regex:String
        switch type {
            case .Email: regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            case .Password: regex = "^(?=.*[0-9]).{6,}"
        }
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
  }

}

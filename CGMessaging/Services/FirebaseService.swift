//
//  FirebaseService.swift
//  CGMessaging
//
//  Created by Mac on 12/3/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseService {
    
    static let root = Database.database().reference()
    static let Groups = root.child("Groups")
    static let Users = root.child("Users")
    
    class func LogOut() {
        do {
           try Auth.auth().signOut()
        } catch let error {
            print("Failed to sign Out! \(error.localizedDescription)")
        }
    }
    
    class func fetchChatMessages(_ chatRef: DatabaseReference, completionhandler:@escaping([Message]?)->()) {
         let msgRef = chatRef.child("Messages")
            msgRef.observe(.value, with: { (snapshot) in
                //  print(snapshot.value)
                if snapshot.exists() {
                    var messageBatch:[Message] = []
                    if let data = snapshot.value as? Dictionary<String,[String:String]> {
                        for dict in data {
                            let newMsg = Message(sender: dict.value["Sender"] ?? "", text: dict.value["Message"] ?? "", time: dict.key, ChatManager.isSender(uid: dict.value["Sender"] ?? "") )
                            messageBatch.append(newMsg)
                        }
                    }
                    completionhandler(messageBatch.sorted(){$0.time < $1.time})
                }
                else {
                    print("Could not fetch Messages!")
                    completionhandler(nil)
                }
            })//end oberserve
    }
    
    class func getSender(uid:String, completionHandler:@escaping(String?)->()) {
        self.Users.observe(.value, with: { (snapshot) in
            if snapshot.exists() {
                let  data = snapshot.value as! Dictionary<String,[String:String]>
                for dict in data {
                    if dict.key == uid {
                        guard let first = dict.value["First"],
                        let last = dict.value["Last"] else {return}
                        completionHandler("\(first) \(last)")
                        return
                    }
                }
                
            }
        })
    }
}

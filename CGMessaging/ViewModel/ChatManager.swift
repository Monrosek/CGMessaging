//
//  ChatViewModel.swift
//  CGMessaging
//
//  Created by Mac on 12/3/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import ChatBubble

struct Message {
    //var name:String?
    var text:String
    var sender:String
    var time:String
    var isSender:Bool
    
    init(sender:String, text:String, time:String, _ isSender:Bool) {
       self.sender = sender
       self.text = text
       self.time = time
       self.isSender = isSender
    }
  
}
class ChatManager: NSObject {
    
    var messages:[Message]? = []
    var chatRef:DatabaseReference?

    override init() {
        super.init()
        self.ChatGroup("Chat1")
    }
    
    func ChatGroup(_ chat:String) {
         self.chatRef = FirebaseService.Groups.child(chat)
    }
    
    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy,MM,dd,HH,mm,ss"
        return formatter.string(from: Date())
    }
    
    static func isSender(uid:String)->Bool {
        guard let user_id = LoginManager.shared.user?.uid else {return false}
        if uid == user_id {
            return true
        }
        return false
    }
    
    
    func Send(text:String) {
      let msgRef = chatRef?.child("Messages")
      let timeStamp = getCurrentTime()
      let post = ["Message":text,"Sender":LoginManager.shared.user?.uid]
      let newMessage = ["/\(timeStamp)":post]
      msgRef?.updateChildValues(newMessage)
    }
}

typealias ChatCollectionFunctions = ChatManager
extension ChatCollectionFunctions: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let user = self.messages?[indexPath.row].isSender else {return UICollectionViewCell()}
        if user == true {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SenderMsgCell.identifier, for: indexPath) as? SenderMsgCell else{return UICollectionViewCell()}
            if let sender = messages?[indexPath.row].sender {
                FirebaseService.getSender(uid: sender) { (name) in
                    guard let name = name else {return}
                    guard let text = self.messages?[indexPath.row].text else {return}
                    DispatchQueue.main.async {
                        cell.sender?.text = name
                        cell.message?.text = text
                    }
                }
                return cell
            }
        }
        else {
            
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceiverMsgCell.identifier, for: indexPath) as? ReceiverMsgCell else{return UICollectionViewCell()}
            if let sender = messages?[indexPath.row].sender {
                FirebaseService.getSender(uid: sender) { (name) in
                    guard let name = name else {return}
                    guard let text = self.messages?[indexPath.row].text else {return}
                    DispatchQueue.main.async {
                        cell.sender?.text = name
                        cell.message?.text = text
                    }
                }
                return cell
            }
        }
    
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    
}

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

struct Message {
    //var name:String?
    var text:String
    var sender:String
    var time:String
    
    init(sender:String, text:String, time:String) {
       self.sender = sender
       self.text = text
       self.time = time
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCell", for: indexPath) as? ChatCell {
            if let sender = messages?[indexPath.row].sender {
                FirebaseService.getSender(uid: sender) { (name) in
                    guard let name = name else {return}
                    DispatchQueue.main.async {
                        cell.sender.text = name
                        cell.message.text = self.messages?[indexPath.row].text
                    }
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    
}

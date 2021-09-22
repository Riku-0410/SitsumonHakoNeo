//
//  Message.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import Foundation
import Firebase
struct Message: Identifiable{
    let text: String
    let user: User
    let toId: String
    let fromId: String
    let read: Bool
    let isFromCurrentUser:Bool
    let id: String
    let timestamp: Timestamp
    
    init(user: User, dictionary: [String:Any]){
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.read = dictionary["read"] as? Bool ?? false
        self.isFromCurrentUser = fromId  == Auth.auth().currentUser?.uid
        self.id = dictionary["id"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}


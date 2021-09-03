//
//  Message.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import Foundation

struct Message: Identifiable{
    let text: String
    let user: User
    let toId: String
    let fromId: String
    let read: Bool
    let id: String
    
    init(user: User, dictionary: [String:Any]){
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.read = dictionary["read"] as? Bool ?? false
        self.id = dictionary["id"] as? String ?? ""
    }
}


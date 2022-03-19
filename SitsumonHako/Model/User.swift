//
//  User.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//
import FirebaseAuth
struct User: Identifiable {
    let id : String
    let anoId: String
    let profileImageUrl: String
    let username : String
    let anoname : String
    let device : String?
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]){
        self.id = dictionary["uid"] as? String ?? ""
        self.anoId = dictionary["anouid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["nickname"] as? String ?? ""
        self.anoname = dictionary["anonickname"] as? String ?? ""
        self.device = dictionary["device"] as? String ?? nil
    }
}

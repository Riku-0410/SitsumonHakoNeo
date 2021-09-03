//
//  User.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

struct User: Identifiable {
    let id : String
    let anoId: String
    let profileImageUrl: String
    let username : String
    let anoname : String
    
    init(dictionary: [String: Any]){
        self.id = dictionary["uid"] as? String ?? ""
        self.anoId = dictionary["anouid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.anoname = dictionary["anoname"] as? String ?? ""
    }
}

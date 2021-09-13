//
//  RegisterInformation.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/13.
//

import Foundation

class RegisterInformation:ObservableObject{
    @Published var userID: String = ""
    @Published var nickName: String = ""
    @Published var anoNickName: String = ""
}

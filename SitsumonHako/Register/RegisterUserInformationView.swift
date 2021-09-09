//
//  RegisterUserInformationView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/04.
//

import SwiftUI
protocol RegisterUserInformationViewDelegate: AnyObject{
    func RegisterUserInformationViewDidTapRegisterButton()
}
struct RegisterUserInformationView: View {
    @State var userID:String = ""
    @State var nickName:String = ""
    @State var anoNickName:String = ""
    weak var delegate:RegisterUserInformationViewDelegate?
    var body: some View {
        ScrollView{
            VStack(alignment:.leading,spacing:12){
                CustomTextFieldView(text: $userID,title:"ユーザーID")
                CustomTextFieldView(text: $nickName, title:"ニックネーム")
                CustomTextFieldView(text: $anoNickName, title:"匿名用ニックネーム" ,caution:"※特定できない名前")
                Button(action:{
                    delegate?.RegisterUserInformationViewDidTapRegisterButton()
                }){
                    Text("次へ")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .fontWeight(.black)
                        .padding(.horizontal, 28)
                        .frame(maxWidth:.infinity)
                }
                .frame(maxWidth:.infinity,minHeight: 40,alignment:.center)
                .background(Color(hex:"657FAD"))
                .padding(.top,40)
            }
            .frame(maxWidth:.infinity)
            .padding(.horizontal, 28)
        }
        .padding(.top, 40)
    }
}


struct RegisterUserInformation_Preview: PreviewProvider {
    static var previews: some View {
        RegisterUserInformationView(userID: "")
    }
}

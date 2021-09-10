//
//  RegisterUserInformationView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/04.
//

import SwiftUI
import FirebaseAuth
protocol RegisterUserInformationViewDelegate: AnyObject{
    func registerUserInformationViewDidTapRegisterButton(userID:String,nickName:String,anoNickName:String)
    func registerUserInformationViewDidTapRegisterImage()
}
struct RegisterUserInformationView: View {
    class DataSource: ObservableObject{
        @Published var userImage:UIImage? = nil
        @Published var userSession: FirebaseAuth.User?
    }
    @ObservedObject var dataSource: DataSource
    @State var userID:String = ""
    @State var nickName:String = ""
    @State var anoNickName:String = ""
    weak var delegate:RegisterUserInformationViewDelegate?
    var body: some View {
        ScrollView{
            registerUserImageSection
            registerUserInformationSection
        }
    }
    
    var registerUserImageSection: some View {
        VStack{
            if let image = dataSource.userImage{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .scaledToFit()
                    .background(Circle())
                    
            }else{
                Circle()
                    .stroke(Color(hex: "B0B6BD"),lineWidth: 1)
                    .frame(width: 150, height: 150, alignment: .center)
                    .background(Color.white)
                    .onTapGesture {
                        delegate?.registerUserInformationViewDidTapRegisterImage()
                        print("didtap")
                    }
            }
            VStack(spacing:0){
                Text("丸の中をタップして画像を登録")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color(hex: "B0B6BD"))
                Text("※画像登録は必須です")
                    .foregroundColor(Color(hex: "E2785A"))
                    .font(.caption2)
                    .padding(.top,6)
            }
        }.padding(.top,40)
    }
    
    var registerUserInformationSection: some View {
        VStack(alignment:.leading,spacing:12){
            CustomTextFieldView(text: $userID,title:"ユーザーID")
            CustomTextFieldView(text: $nickName, title:"ニックネーム")
            CustomTextFieldView(text: $anoNickName, title:"匿名用ニックネーム" ,caution:"※特定できない名前")
            Button(action:{
                delegate?.registerUserInformationViewDidTapRegisterButton(userID: userID, nickName: nickName, anoNickName: anoNickName)
            }){
                Text("登録")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .fontWeight(.black)
                    .padding(.horizontal, 28)
                    .frame(maxWidth:.infinity)
            }
            .frame(maxWidth:.infinity,minHeight: 40,alignment:.center)
            .background(Color(hex:"657FAD"))
            .padding(.top,10)
        }
        .frame(maxWidth:.infinity)
        .padding(.horizontal, 28)
        .padding(.top, 40)
    }

}


struct RegisterUserInformation_Preview: PreviewProvider {
    static var previews: some View {
        RegisterUserInformationView(dataSource: .init(), userID: "")
    }
}

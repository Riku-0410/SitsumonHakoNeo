//
//  RegisterUserImageView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/05.
//

import SwiftUI

protocol RegisterUserImageViewDelegate:AnyObject {
    func registerUserImageViewDidTapImage()
}

struct RegisterUserImageView: View {
    class DataSource: ObservableObject{
        @Published var userImage:UIImage? = nil
    }
    
    weak var delegate: RegisterUserImageViewDelegate?
    @ObservedObject var dataSource: DataSource
    var body: some View {
        ScrollView{
            VStack(spacing:24){
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
                            delegate?.registerUserImageViewDidTapImage()
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
                Button(action:{
                    
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
                .padding(.top,40)
            }
            .frame(maxWidth:.infinity)
            .padding(.top,40)
           

        }
        .padding(.horizontal,20)

        
    }
}


struct RegisterUserImageView_Preview: PreviewProvider {
    static var previews: some View {
        RegisterUserImageView(dataSource:.init())
    }
}

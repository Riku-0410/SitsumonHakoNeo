//
//  RegisterView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/03.
//

import SwiftUI

protocol RegisterTopViewDelegate: AnyObject {
    func registerTopViewDidTapRegisterButton()
}

struct RegisterTopView: View {
    var screenSize = UIScreen.main.bounds.size
    weak var delegate: RegisterTopViewDelegate?
    var body: some View {
        ScrollView{
            HStack{
                Text("登録して始める")
            }
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .padding(.horizontal)
            .onTapGesture {
                delegate?.registerTopViewDidTapRegisterButton()
                print("didtap")
            }
        }
    }
}

struct RegisterTopView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTopView()
    }
}

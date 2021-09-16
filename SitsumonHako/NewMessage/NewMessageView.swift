//
//  NewMessageView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/09.
//

import SwiftUI

protocol NewMessageViewDelegate:AnyObject {
    func newMessageViewDidTapUserCell(user:User)
}
struct NewMessageView: View {
    class DataSource: ObservableObject{
        @Published var user: [User] = [
            User(dictionary: ["id":"1","anoId":"a1","nickname":"riku","anonickname":"toku"]),
            User(dictionary: ["id":"1","anoId":"a1","nickname":"riku","anonickname":"toku"]),
            User(dictionary: ["id":"1","anoId":"a1","nickname":"riku","anonickname":"toku"]),
            User(dictionary: ["id":"1","anoId":"a1","nickname":"riku","anonickname":"toku"]),
        ]
        @Published var isLoading:Bool = false
    }
    
    weak var delegate:NewMessageViewDelegate?
    @ObservedObject var dataSource: DataSource
    var body: some View {
        ScrollView(){
            VStack(spacing:0){
                ForEach(dataSource.user){ user in
                    UserCell(user: user).onTapGesture {
                        self.delegate?.newMessageViewDidTapUserCell(user:user)
                    }
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(dataSource: .init())
    }
}

//
//  NewMessageView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/09.
//

import SwiftUI

protocol NewMessageViewDelegate:AnyObject {
    func newMessageViewDidTapUserCell(user:User)
    func newMessageViewSearchUser(text:String)
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
    @State var searchText:String = ""
    var body: some View {
        ScrollView(){
            SearchBar(text: $searchText, placeholder: "id検索")
            VStack(spacing:0){
                ForEach(dataSource.user){ user in
                    UserCell(user: user).onTapGesture {
                        self.delegate?.newMessageViewDidTapUserCell(user:user)
                    }
                }
            }.onChange(of: searchText, perform: { _ in
                self.delegate?.newMessageViewSearchUser(text: searchText)
            })
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(dataSource: .init())
    }
}

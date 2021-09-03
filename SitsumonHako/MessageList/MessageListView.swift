//
//  MessageView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import SwiftUI


protocol MessageListViewDelegate: AnyObject {
    func messageListViewDidTapMessageCell()
}

struct MessageListView: View {
    class DataSource: ObservableObject{
        @Published var recentMessage: [Message] = [Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123])]
    }
    
    weak var delegate: MessageListViewDelegate?
    @ObservedObject var dataSource: DataSource
    
    var body: some View{
        ScrollView{
            VStack(){
                ForEach(dataSource.recentMessage){ message in
                    MessageCell(message:message)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .background(Color.white)
                    .onTapGesture {
                        delegate?.messageListViewDidTapMessageCell()
                    }
                }
            }
        }
    }
}


struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView(dataSource: .init())
    }
}

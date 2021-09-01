//
//  MessageView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import SwiftUI


protocol MessageViewDelegate: AnyObject {
    func messageViewDidTapMessageCell()
}
struct MessageView: View {
    class DataSource: ObservableObject{
        @Published var recentMessage: [Message] = [Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123])]
    }
    
    weak var delegate: MessageViewDelegate?
    @ObservedObject var dataSource: DataSource
    
    var body: some View{
        ZStack(alignment: .bottomTrailing){
            ScrollView{
                VStack{
                    ForEach(dataSource.recentMessage){ message in
                        MessageCell(message:message).onTapGesture {
                            delegate?.messageViewDidTapMessageCell()
                        }
                    }
                }
            }
        }
    }
}


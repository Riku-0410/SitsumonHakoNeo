//
//  MessageView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import SwiftUI


protocol MessageListViewDelegate: AnyObject {
    func messageListViewDidTapMessageCell()
    func messageListViewDidTapNewMessageButton()
}

struct MessageListView: View {
    
    class DataSource: ObservableObject{
        @Published var recentMessage: [Message] = [Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123])]
    }
    
    weak var delegate: MessageListViewDelegate?
    @ObservedObject var dataSource: DataSource
    
    var body: some View{
        ZStack(alignment:.bottomTrailing){
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
            newMessageButton
        }
    }
    
    var newMessageButton: some View {
        HStack{
            Spacer()
            Button(action: {
                self.delegate?.messageListViewDidTapNewMessageButton()
            }, label: {
                Image(systemName: "envelope")
                    .resizable()
                    .font(Font.title.weight(.light))
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding()
            })
            .background(Color(hex: "4B98E5"))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
        }
        
    }
}


struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView(dataSource: .init())
    }
}

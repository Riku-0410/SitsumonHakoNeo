//
//  SwiftUIView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/03.
//

import SwiftUI

struct MessageDetailView: View {
    class DataSource: ObservableObject{
        @Published var message: [Message] = [Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"2","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]),Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123])]
    }
    @State var text:String = ""
    @ObservedObject var dataSource: DataSource

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(dataSource.message) { message in
                        MessageDetailCell(message:message)
                    }
                    
                }
                .flippedUpsideDown()
            }
            .flippedUpsideDown()
            MessageDetailInputView(text:$text)
        }
    }
}

struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MessageDetailView(dataSource: .init())
    }
}

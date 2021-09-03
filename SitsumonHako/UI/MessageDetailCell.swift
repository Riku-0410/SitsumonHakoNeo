//
//  MessageDetailCell.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/03.
//

import SwiftUI

struct MessageDetailCell: View {
    let message: Message
    
    var body: some View {
        HStack(spacing:0){
            Text(message.text)
                .padding()
                .background(Color(.blue))
                .clipShape(MessageDetailBubble())
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.leading, 100)
                .padding(.trailing, 8)
            }
        }

}

struct MessageDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageDetailCell(message: Message(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"こんにちは","toId":"2","fromId":"1","read":true,"id":123]))
    }
}

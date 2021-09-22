//
//  MessageCell.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import SwiftUI


struct MessageCell: View {
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading,spacing:0) {
            HStack(alignment:.top,spacing: 12) {
                URLImageView(viewModel: .init(url: message.user.profileImageUrl))
                    .frame(width: 52, height: 52)
                    .padding(4)
                VStack(alignment: .leading, spacing: 0) {
                    Text(message.user.username)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.top,4)
                    Text(message.text)
                        .font(.system(size: 14))
                        .lineLimit(2)
                }
                .foregroundColor(.black)
                .padding(.trailing)
                .padding(.top, 4)
            }
            .frame(height:60)
        }
    }
}



struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageCell(message: Message(user: User(dictionary: ["username":"rikuya"]), dictionary: ["text":"ああああ"]))
    }
}

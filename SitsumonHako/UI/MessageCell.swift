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
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.user.username)
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text(message.text)
                            .font(.system(size: 14))
                            .lineLimit(2)
                    }
                    .foregroundColor(.black)
                    .padding(.trailing)
                    Spacer()
            }
            Divider()
        }.frame(maxWidth:.infinity)
    }
}


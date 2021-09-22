//
//  AnoMessageDetailCell.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/21.
//

import SwiftUI

struct AnoMessageDetailCell: View {
    let message: AnoMessage
    
    var body: some View {
        if !message.isFromCurrentUser{
            HStack(spacing:0){
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                Text(message.text)
                    .font(.callout)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 14)
                    .background(Color(.gray))
                    .clipShape(MessageDetailBubble())
                    .foregroundColor(.black)
                    .padding(.trailing, 100)
                    .padding(.leading, 4)
                }
            .frame(maxWidth:.infinity ,alignment: .leading)
            .padding(.leading ,4)
        
        }else{
            HStack(spacing:0){
                Text(message.text)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 14)
                    .background(Color(.blue))
                    .clipShape(MessageDetailBubble())
                    .foregroundColor(.white)
                    .padding(.leading, 100)
                }
            .frame(maxWidth:.infinity ,alignment: .trailing)
            .padding(.trailing,4)
            }
        }

}

struct AnoMessageDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        AnoMessageDetailCell(message: AnoMessage(user: User(dictionary: ["id":"1","anoId":"a1","username":"riku","anoname":"toku"]), dictionary: ["text":"あああああああああああああああああああ","toId":"2","fromId":"2","read":true,"id":123]))
    }
}

//
//  AnoMessageCell.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/21.
//


import SwiftUI


struct AnoMessageCell: View {
    let message: AnoMessage
    
    var body: some View {
        VStack(alignment: .leading,spacing:0) {
            HStack(alignment:.top,spacing: 12) {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 52, height: 52)
                    .padding(4)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(message.user.anoname)
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



struct AnoMessageCell_Previews: PreviewProvider {
    static var previews: some View {
        AnoMessageCell(message: AnoMessage(user: User(dictionary: ["username":"rikuya"]), dictionary: ["text":"ああああ"]))
    }
}

//
//  UserCell.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/09.
//

import SwiftUI


struct UserCell: View {
   let user: User
    
    var body: some View {
        HStack(spacing: 0) {
//            URLImageView(viewModel: URL(string: user.profileImageUrl))
//                .resizable()
//                .scaledToFill()
//                .clipped()
//                .frame(width: 56, height: 56)
//                .cornerRadius(28)
            Rectangle()
                .frame(width: 52, height: 52)
                .cornerRadius(28)
                .padding(.horizontal,4)
                .padding(.vertical, 4)
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.callout)
                    .padding(.horizontal, 6)
            }
            .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: User(dictionary: ["id" : "12346", "username":"riku"]))
    }
}

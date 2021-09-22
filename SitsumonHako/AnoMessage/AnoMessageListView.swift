//
//  AnoMessageView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/02.
//

import SwiftUI

protocol AnoMessageListViewDelegate: AnyObject {
    func anoMessageListViewDidTapMessageCell(user:User)
}

struct AnoMessageListView: View {
    
    class DataSource: ObservableObject{
        @Published var recentMessage: [AnoMessage] = []
    }
    
    weak var delegate: AnoMessageListViewDelegate?
    @ObservedObject var dataSource: DataSource
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            ScrollView{
                VStack(){
                    ForEach(dataSource.recentMessage){ message in
                        AnoMessageCell(message:message)
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .background(Color.white)
                        .onTapGesture {
                            delegate?.anoMessageListViewDidTapMessageCell(user:message.user)
                        }
                    }
                }
            }
        }
    }
}

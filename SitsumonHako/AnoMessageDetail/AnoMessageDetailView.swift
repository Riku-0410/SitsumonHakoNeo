//
//  AnoMessageDetailView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/21.
//

import SwiftUI

protocol AnoMessageDetailViewDelegate: AnyObject{
    func anoMessageDetailViewDidSendMessage(messageText:String)
}

struct AnoMessageDetailView: View {
    class DataSource: ObservableObject{
        @Published var message: [AnoMessage] = []
        @Published var didLoadFinished:Bool = false
    }
    @State var text:String = ""
    @ObservedObject var dataSource: DataSource
    weak var delegate:AnoMessageDetailViewDelegate?
    //データ取れるまでローディング取れたらEmptyView取れる様に
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader {(proxy: ScrollViewProxy) in
                    // https://www.memory-lovers.blog/entry/2020/05/24/180000
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(dataSource.message) { message in
                            AnoMessageDetailCell(message:message).id(message.id)
                     
                        }
                    }
                .flippedUpsideDown()
                }
            }
            .flippedUpsideDown()
            MessageDetailInputView(text:$text,action:sendMessage)
        }
    }
    
    func sendMessage(){
        self.delegate?.anoMessageDetailViewDidSendMessage(messageText: text)
    }
}

struct AnoMessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnoMessageDetailView(dataSource: .init())
    }
}

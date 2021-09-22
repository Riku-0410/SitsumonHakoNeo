//
//  AnoMessageDetailView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/21.
//

import SwiftUI

protocol AnoMessageDetailViewDelegate: AnyObject{
    func anoMessageDetailViewDidSendMessage(messageText:String)
    func anoMessageDetailViewUpdateMessage()
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
                    
                    LazyVStack(alignment: .leading, spacing: 12) {
                        //Lineのトークみたいにするのに技術調査が必要
                        //あとでやるとして別に二十件までしか取れないとかでもいいかも
    //                    if !dataSource.message.isEmpty{
    //                        Text("heelo")
    //                        .onAppear{
    //                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
    //                                self.delegate?.anoMessageDetailViewUpdateMessage()
    //                            }
    //
    //                            print("hello")
    //                        }
    //                    }
                        ForEach(dataSource.message) { message in
                            AnoMessageDetailCell(message:message).id(message.id)
                        }
                        .onChange(of: dataSource.didLoadFinished){_ in
                            proxy.scrollTo(dataSource.message.last?.id, anchor: .bottom)
                            print("print")
                        }
//                        .onReceive(dataSource.$message){ id in
//                            proxy.scrollTo(dataSource.message.last?.id, anchor: .bottom)
//                            print("print")
//                        }
                    }
                    //これはタイミングが悪いから？
                    .onAppear(){
                        proxy.scrollTo(dataSource.message.last?.id, anchor: .bottom)
                    }

    //                .flippedUpsideDown()

                }
            }
//            .flippedUpsideDown()
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

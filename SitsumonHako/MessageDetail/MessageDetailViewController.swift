//
//  MessageDetailViewController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/03.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
class MessageDetailViewController: UIViewController , MessageDetailViewDelegate{

    
    private let dataSource: MessageDetailView.DataSource = .init()
    var user:User? = nil
    //HACK:temporary あとで調べる
    convenience init(user:User) {
        self.init(nibName: nil, bundle: nil)
        fetchMessage(user: user)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let rootView = MessageDetailView(dataSource: dataSource,delegate: self)
        let hostingVC = UIHostingController(rootView: rootView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingVC.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingVC.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingVC.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func fetchMessage(user:User){
        self.user = user
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        let anoID = user.anoId
        let query = Firestore.firestore().collection("message").document(currentUID).collection(anoID)
        query.addSnapshotListener{ snapshot,err in
            guard let addChange = snapshot?.documentChanges.filter({$0.type == .added}) else {return}
            addChange.forEach{ snapshot in
                let messageData = snapshot.document.data()
                let fromId = messageData["fromId"] as! String
                if fromId  == currentUID{
                    Firestore.firestore().collection("user").document(fromId).getDocument { snapshot, _ in
                        guard let data = snapshot?.data() else {return}
                        let user = User(dictionary: data)
                        self.dataSource.message.append(Message(user: user, dictionary: messageData))
                        self.dataSource.message.sort(by:{ $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                    }
                }else{
                    guard let user = self.user else { return }
                    self.dataSource.message.append(Message(user:user ,dictionary: messageData))
                }
            }
        }
    }
    
    func messageDetailViewDidSendMessage(messageText: String) {
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        guard let anoUID = self.user?.anoId else {return}
        Firestore.firestore().collection("user").whereField("anouid", isEqualTo: anoUID).getDocuments{
            query,error in
            for document in query!.documents {
                let datas = document.data()
                let device = datas["device"] ?? ""
                let currentUserRef = Firestore.firestore().collection("message").document(currentUID).collection(anoUID).document()
                let receivingUserRef = Firestore.firestore().collection("message").document(anoUID).collection(currentUID)
                let receivingRecentRef = Firestore.firestore().collection("message").document(anoUID).collection("recent-messages")
                let currentRecentRef = Firestore.firestore().collection("message").document(currentUID).collection("recent-messages")
                let messageID = currentUserRef.documentID
                
                let data: [String: Any] = ["text": messageText,
                                           "id":messageID,
                                           "fromId":currentUID,
                                           "toId":anoUID,
                                           "read":false,
                                           "timestamp": Timestamp(date: Date()),
                                           "device": device]
                currentUserRef.setData(data)
                currentRecentRef.document(anoUID).setData(data)
                receivingUserRef.document(messageID).setData(data)
                receivingRecentRef.document(currentUID).setData(data)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  AnoMessageDetailViewControlelr.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/21.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
class AnoMessageDetailViewController: UIViewController, AnoMessageDetailViewDelegate{
    

    private let dataSource: AnoMessageDetailView.DataSource = .init()
    var lastDoc :QueryDocumentSnapshot!
    var user:User? = nil
    //HACK:temporary あとで調べる
    convenience init(user:User) {
        self.init(nibName: nil, bundle: nil)
        fetchMessage(user: user){_ in
            self.dataSource.didLoadFinished = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let rootView = AnoMessageDetailView(dataSource: dataSource,delegate: self)
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
    //:Anomessage使ってcurrentUserかどうか判断
    func fetchMessage(user:User, completion: @escaping (Bool) -> ()) {

        self.user = user
        Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).getDocument{ document,error in
            guard let data = document?.data() else {return}
            let anoUID = data["anouid"] as! String
            let currentUser = User(dictionary: data)
            let UID = user.id
            let query = Firestore.firestore().collection("message").document(anoUID).collection(UID).limit(to:20).order(by: "timestamp" , descending: true)
            query.addSnapshotListener{ snapshot, _ in
                snapshot!.documents.forEach{ document in
                    var messageData = document.data()
                    let fromId = messageData["fromId"] as! String
                    if fromId == anoUID{
                            messageData["isFromCurrentUser"] = true
                            self.dataSource.message.append(AnoMessage(user: currentUser, dictionary: messageData))
                            self.dataSource.message.sort(by:{ $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                        
                    }else{
                        guard let user = self.user else { return }
                        messageData["isFromCurrentUser"] = false
                        self.dataSource.message.append(AnoMessage(user:user ,dictionary: messageData))
                    }
                }
            }
            
        }
    }
    
    func anoMessageDetailViewDidSendMessage(messageText: String) {
        Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).getDocument{ document,error in
            guard let anoUIDData = document?.data() else {return}
            let anoUID = anoUIDData["anouid"] as! String
            guard let UID = self.user?.id else {return}
            var fcmToken = ""
            if let device = self.user?.device {
                fcmToken = device
            }
            let currentUserRef = Firestore.firestore().collection("message").document(anoUID).collection(UID).document()
            let receivingUserRef = Firestore.firestore().collection("message").document(UID).collection(anoUID)
            let receivingRecentRef = Firestore.firestore().collection("message").document(UID).collection("recent-messages")
            let currentRecentRef = Firestore.firestore().collection("message").document(anoUID).collection("recent-messages")
            let messageID = currentUserRef.documentID
            
            let data: [String: Any] = ["text": messageText,
                                       "id":messageID,
                                       "fromId":anoUID,
                                       "toId":UID,
                                       "read":false,
                                       "timestamp": Timestamp(date: Date()),
                                       "device": fcmToken]
            currentUserRef.setData(data)
            currentRecentRef.document(UID).setData(data)
            receivingUserRef.document(messageID).setData(data)
            receivingRecentRef.document(anoUID).setData(data)
            
        }
    }
    

}

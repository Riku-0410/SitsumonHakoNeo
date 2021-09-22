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
            let UID = user.id
            let query = Firestore.firestore().collection("message").document(anoUID).collection(UID)
            query.addSnapshotListener{ snapshot, _ in
                guard let addChange = snapshot?.documentChanges.filter({$0.type == .added}) else {return}
                addChange.forEach{ snapshot in
                    
                    var messageData = snapshot.document.data()
                    let fromId = messageData["fromId"] as! String
                    let currentUID = Auth.auth().currentUser!.uid
                    if fromId == anoUID{
                        Firestore.firestore().collection("user").document(currentUID).getDocument { snapshot, _ in
                            messageData["isFromCurrentUser"] = true

                            guard let data = snapshot?.data() else {return}
                            let user = User(dictionary: data)
                            self.dataSource.message.append(AnoMessage(user: user, dictionary: messageData))
                            self.dataSource.message.sort(by:{ $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                            self.dataSource.didLoadFinished = true
                            print(1)
                        }
                    }else{
                        guard let user = self.user else { return }
                        messageData["isFromCurrentUser"] = false
                        self.dataSource.message.append(AnoMessage(user:user ,dictionary: messageData))
                        self.dataSource.didLoadFinished = true
                    }
                }
                self.lastDoc = snapshot!.documents.last
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
    
    func anoMessageDetailViewUpdateMessage() {
        Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).getDocument{ document,error in
            guard let data = document?.data() else {return}
            let anoUID = data["anouid"] as! String
            guard let UID = self.user?.id else { return }
            let query = Firestore.firestore().collection("message").document(anoUID).collection(UID).start(afterDocument: self.lastDoc).limit(to: 20)
            query.addSnapshotListener{ snapshot, _ in
                guard let addChange = snapshot?.documentChanges.filter({$0.type == .added}) else {return}
                addChange.forEach{ snapshot in
                    var messageData = snapshot.document.data()
                    let fromId = messageData["fromId"] as! String
                    let currentUID = Auth.auth().currentUser!.uid
                    if fromId == anoUID{
                        Firestore.firestore().collection("user").document(currentUID).getDocument { snapshot, _ in
                            messageData["isFromCurrentUser"] = true

                            guard let data = snapshot?.data() else {return}
                            let user = User(dictionary: data)
                            self.dataSource.message.append(AnoMessage(user: user, dictionary: messageData))
                            self.dataSource.message.sort(by:{ $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                        }
                    }else{
                        guard let user = self.user else { return }
                        messageData["isFromCurrentUser"] = false
                        self.dataSource.message.append(AnoMessage(user:user ,dictionary: messageData))
                    }
                }
                
                self.lastDoc = snapshot!.documents.last
            }
            
        }
    }
    

}

//
//  NotificationController.swift
//  InstagramCloneApp
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
class AnoMessageListViewController: UIViewController, AnoMessageListViewDelegate{

    
    private let dataSource: AnoMessageListView.DataSource = .init()
    private var recentMessagesDictionary = [String: AnoMessage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecentMessage()
        view.backgroundColor = .blue
        self.navigationItem.title = "相手には自分がわかる"
        let rootView = AnoMessageListView(delegate: self, dataSource: dataSource)
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
    
    
    func anoMessageListViewDidTapMessageCell(user: User) {
        let vc = AnoMessageDetailViewController(user: user)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchRecentMessage(){
        Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).getDocument{ document,error in
            guard let data = document?.data() else {return}
            let anoUID = data["anouid"] as! String
            
            let query = Firestore.firestore().collection("message").document(anoUID).collection("recent-messages")
            query.addSnapshotListener{ snapShot, _ in
                guard let changes = snapShot?.documentChanges else { return }
                changes.forEach{ change in
                    let messageData = change.document.data()
                    let receiveUID = change.document.documentID
                    Firestore.firestore().collection("user").whereField("uid", isEqualTo: receiveUID).getDocuments{ snapShot, _ in
                        for document in snapShot!.documents {
                            let recieveUserData:User = User(dictionary: document.data())
                            self.recentMessagesDictionary[receiveUID] = AnoMessage(user: recieveUserData, dictionary: messageData)
                            self.dataSource.recentMessage = Array(self.recentMessagesDictionary.values)
                        }
                        
                    }
                }
            }
        }
    }

}

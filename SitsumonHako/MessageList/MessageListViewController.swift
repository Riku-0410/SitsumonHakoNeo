//
//  FeedController.swift
//  InstagramCloneApp
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
class MessageListViewController: UIViewController, MessageListViewDelegate{

    private let dataSource: MessageListView.DataSource = .init()
    private var recentMessagesDictionary = [String: Message]()
    let newMessageViewController = NewMessageViewController()
    var user:User?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.navigationItem.title = "message"
        let rootView = MessageListView(delegate: self, dataSource: dataSource)
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
        fetchRecentMessage()
        
        

    }
    
    func messageListViewDidTapMessageCell(user:User) {
        let vc = MessageDetailViewController(user: user)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func messageListViewDidTapNewMessageButton() {
        let vc = NewMessageViewController()
        vc.presentationController?.delegate = self
        present(vc,animated: true)
    }
    
    func newMessageViewModalDidFinished(user: User) {
        self.newMessageViewController.dismiss(animated: true)
        let vc = MessageDetailViewController(user:user)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchRecentMessage(){
        guard let UID = Auth.auth().currentUser?.uid else { return }
        let query = Firestore.firestore().collection("message").document(UID).collection("recent-messages")
        query.order(by: "timestamp", descending: true)
        query.addSnapshotListener{ snapshot, _ in
            guard let changes = snapshot?.documentChanges else { return }
            changes.forEach{ change in
                let messageData = change.document.data()
                let receiveUID = change.document.documentID
                Firestore.firestore().collection("user").whereField("anouid", isEqualTo: receiveUID).getDocuments{ snapshot, _ in
                    for document in snapshot!.documents {
                        let recieveUserData:User = User(dictionary: document.data())
                        self.recentMessagesDictionary[receiveUID] = Message(user: recieveUserData, dictionary: messageData)
                        self.dataSource.recentMessage = Array(self.recentMessagesDictionary.values)
                    }
                }
            }
        }
    }
}

extension MessageListViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        guard let user = user else {return}
        let vc = MessageDetailViewController(user: user)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

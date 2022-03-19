//
//  NewMessageViewController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/09.
//

import UIKit
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

enum SearchViewModelConfiguration{
    case search
    case newMessage
}
class NewMessageViewController: UIViewController,NewMessageViewDelegate {
    private let dataSource: NewMessageView.DataSource = .init()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.navigationItem.title = "new message"
        let rootView = NewMessageView(delegate: self, dataSource: dataSource)
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
        
        fetchUsers(forConfig: .newMessage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchUsers(forConfig config: SearchViewModelConfiguration){
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        print(currentUser.uid)
        Firestore.firestore().collection("user").document(currentUser.uid).getDocument(){document,error in
            guard let document = document else {return}
            Firestore.firestore().collection("user").end(beforeDocument: document).limit(to:10).getDocuments{ snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.map({ User(dictionary: $0.data() )})
                switch config{
                case .newMessage:
                    self.dataSource.user = users
                case .search:
                    self.dataSource.user = documents.map({ User(dictionary: $0.data())})
                    
                }
            }

        }
    }
 
    
    //TODO:https://puroguradesu.hatenadiary.jp/entry/2021/01/27/034152参考にして直す
    func newMessageViewDidTapUserCell(user:User) {
        guard let tabcon = presentingViewController as? MainTabController else {return}
        guard let navigation = tabcon.selectedViewController as? UINavigationController else {return}
        guard let prevView = navigation.topViewController as? MessageListViewController else {return}
        let vc = prevView
        vc.user = user
        self.dismiss(animated: true)
    }
    
    func newMessageViewSearchUser(text: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        Firestore.firestore().collection("user").whereField("anouid", isEqualTo: text).limit(to:1).getDocuments{ snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let users = documents.map({ User(dictionary: $0.data() )})
            self.dataSource.user = users.filter{ !$0.isCurrentUser}
        }

    }
}

extension NewMessageViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

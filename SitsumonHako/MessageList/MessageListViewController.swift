//
//  FeedController.swift
//  InstagramCloneApp
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import UIKit
import SwiftUI
class MessageListViewController: UIViewController, MessageListViewDelegate{
    private let dataSource: MessageListView.DataSource = .init()
    
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
    }
    
    func messageListViewDidTapMessageCell() {
        let vc = MessageDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func messageListViewDidTapNewMessageButton() {
        let vc = NewMessageViewController()
        present(vc, animated: true)
    }

}

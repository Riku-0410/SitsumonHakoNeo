//
//  FeedController.swift
//  InstagramCloneApp
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import UIKit
import SwiftUI
class MessageViewController: UIViewController,MessageViewDelegate{
    private let dataSource: MessageView.DataSource = .init()
    override func viewDidLoad() {
        super.viewDidLoad()

        let rootView = MessageView(delegate: self, dataSource: dataSource)
        let hostingVC = UIHostingController(rootView: rootView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func messageViewDidTapMessageCell() {
        print("didtap")
    }
    
    

}

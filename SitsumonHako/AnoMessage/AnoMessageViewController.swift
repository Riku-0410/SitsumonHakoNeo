//
//  NotificationController.swift
//  InstagramCloneApp
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import UIKit
import SwiftUI
class AnoMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let rootView = AnoMessageView()
        let hostingVC = UIHostingController(rootView: rootView)
        addChild(hostingVC)
    }
    
    

}

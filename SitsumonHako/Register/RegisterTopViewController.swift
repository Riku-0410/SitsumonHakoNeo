//
//  RegisterTopViewController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/03.
//

import UIKit
import SwiftUI

class RegisterTopViewController: UIViewController, RegisterTopViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let rootView = RegisterTopView(delegate: self)
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
    
    func registerTopViewDidTapRegisterButton() {
        let vc = RegisterUserInformationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

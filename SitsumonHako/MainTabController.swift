//
//  MainTabController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureViewControllers()
        // Do any additional setup after loading the view.
    }
    
    func configureViewControllers() {
        let message = templateNavigationController(unselectedImage: UIImage(systemName: "person.crop.circle.badge.checkmark")!, selectedImage: UIImage(systemName: "person.crop.circle.fill.badge.checkmark")!, rootViewController: MessageViewController())
        let anoMessage = templateNavigationController(unselectedImage: UIImage(systemName: "person.crop.circle.badge.questionmark")!, selectedImage: UIImage(systemName: "person.crop.circle.badge.questionmark")!, rootViewController: AnoMessageViewController())
        let profile = templateNavigationController(unselectedImage: UIImage(systemName: "person.crop.circle")!, selectedImage: UIImage(systemName: "person.crop.circle.fill")!, rootViewController: ProfileViewController())
            
        viewControllers = [message,anoMessage,profile]
        
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .blue
        return nav
    }
}

//
//  MainTabController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/01.
//

import UIKit
import FirebaseAuth
class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        checkIfUserIsLoggedIn()
//
//        do {
//          try Auth.auth().signOut()
//          print("sign out")
//        } catch let signOutError as NSError {
//          print("Error signing out: %@", signOutError)
//        }
    }
    //HACK:こいつ動かすとnavigationViewが変な挙動になる
//    override func viewDidAppear(_ animated: Bool) {
////
//    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = RegisterUserInformationViewController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func configureViewControllers() {
        let message = templateNavigationController(unselectedImage: UIImage(systemName: "person.crop.circle.badge.checkmark")!, selectedImage: UIImage(systemName: "person.crop.circle.fill.badge.checkmark")!, rootViewController: MessageListViewController())
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

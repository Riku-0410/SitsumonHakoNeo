//
//  RegisterUserInformationViewController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/04.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
class RegisterUserInformationViewController: UIViewController,RegisterUserInformationViewDelegate{

    
    private let dataSource: RegisterUserInformationView.DataSource = .init()
    var service:AuthService = AuthService()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let rootView = RegisterUserInformationView(dataSource: dataSource, delegate:self)
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
        // Do any additional setup after loading the view.
    }

    
    func registerUserInformationViewDidTapRegisterButton(userID:String,nickName:String,anoNickName:String) {
        Auth.auth().signInAnonymously(completion: ){ (authResult, error) in
            if let error = error{
                
            }
            guard let user = authResult?.user else { return }
            let data = [
                "nickname":nickName,
                "anoNickName":anoNickName,
                "uid":user.uid,
                "anouid":userID
            ]
            
            Firestore.firestore().collection("user").document(user.uid).setData(data){ _ in
                self.dataSource.userSession = user
            }
        }
        
    }
    
    func registerUserInformationViewDidTapRegisterImage() {
        let pickerContoller = UIImagePickerController()
        pickerContoller.allowsEditing = true
        pickerContoller.delegate = self
        pickerContoller.sourceType = .photoLibrary
        self.present(pickerContoller, animated: true)
    }

}
extension RegisterUserInformationViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage{
            self.dataSource.userImage = image
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

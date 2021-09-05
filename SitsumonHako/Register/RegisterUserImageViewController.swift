//
//  RegisterUserImageViewController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/05.
//

import SwiftUI
import UIKit
class RegisterUserImageViewController: UIViewController, RegisterUserImageViewDelegate{
    private let dataSource: RegisterUserImageView.DataSource = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let rootView = RegisterUserImageView(delegate: self, dataSource: dataSource)
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
    
    func registerUserImageViewDidTapImage(){
        let pickerContoller = UIImagePickerController()
        pickerContoller.allowsEditing = true
        pickerContoller.delegate = self
        pickerContoller.sourceType = .photoLibrary
        self.present(pickerContoller, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegisterUserImageViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            self.dataSource.userImage = image
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

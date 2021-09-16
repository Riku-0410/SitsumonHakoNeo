//
//  RegisterUserInformationViewController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/04.
//

//ミニアプリで実装可能なことがわかるまでRxSwiftで書かない


import UIKit
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import RxSwift
import RxCocoa
class RegisterUserInformationViewController: UIViewController,RegisterUserInformationViewDelegate{
    
    private let disposeBag = DisposeBag()
    private let dataSource: RegisterUserInformationView.DataSource = .init()
    static let shared = RegisterUserInformationViewController()
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
        self.dataSource.isLoading = true
        
        Firestore.firestore().collection("user").whereField("anouid", isEqualTo: userID)
            .getDocuments(){(querySnapshot, err) in
            if querySnapshot!.documents.count == 0{
                guard let imageData = self.dataSource.userImage?.jpegData(compressionQuality: 0.3) else { return }
                let filename = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child(filename)
                
                storageRef.putData(imageData, metadata: nil){_, error in
                    storageRef.downloadURL { url, _ in
                        guard let profileImageUrl = url?.absoluteString else { return }
                        
                        Auth.auth().signInAnonymously(completion: ){ (authResult, error) in
                            guard let user = authResult?.user else { return }
                            let data = ["nickname": nickName,
                                        "anonickname": anoNickName,
                                    "profileImageUrl":profileImageUrl,
                                    "uid":user.uid,
                                    "anouid":userID,
                            ]
                    
                            Firestore.firestore().collection("user").document(user.uid).setData(data){ _ in
                                self.dataSource.userSession = user
                                self.dataSource.isLoading = false
                                self.dismiss(animated: true)
                            }
                        }
                    }
                }
            }else{
                self.dataSource.isLoading = false
                return
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

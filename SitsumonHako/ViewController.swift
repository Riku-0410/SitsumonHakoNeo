//
//  ViewController.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/08/28.
//

import UIKit

class ViewController: UIViewController {
    let titleLabel: UILabel = {
        let view = UILabel.init()
        view.text = "Hello World!"
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var button: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.setTitle("下から出てくるやつ", for: .normal)
        view.addTarget(self, action: #selector(openModal(_:)), for: .touchDown)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc func openModal(_ sender: UIButton) {
        let modalViewController = ModalViewController.init()
        present(modalViewController, animated: true, completion: nil)
    }

}


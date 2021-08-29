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
        view.text = "Hello World"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            
        ])
        
        
        // Do any additional setup after loading the view.
    }


}


//
//  ViewController.swift
//  append
//
//  Created by Patrick Cui on 9/10/21.
//

import UIKit

class Home: UIViewController {
    
    @objc func addPass(sender: UIButton) {
        sender.showAnimation {
            
        }
    }
    
    func layoutUI() {
        let logoView = UIImageView()
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.image = UIImage(named: "logo")
        logoView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        logoView.contentMode = .scaleAspectFit
        
        let addPassButton = UIButton()
        view.addSubview(addPassButton)
        addPassButton.translatesAutoresizingMaskIntoConstraints = false
        addPassButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        addPassButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        addPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPassButton.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 30).isActive = true
        addPassButton.addTarget(self, action: #selector(addPass), for: .touchUpInside)
        addPassButton.backgroundColor = Color.card
        addPassButton.layer.cornerRadius = 10
        addPassButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addPassButton.layer.shadowColor = UIColor.black.cgColor
        addPassButton.layer.shadowRadius = 15
        addPassButton.layer.shadowOpacity = 0.25
        
        let addNewPass = UILabel()
        addPassButton.addSubview(addNewPass)
        addNewPass.translatesAutoresizingMaskIntoConstraints = false
        addNewPass.isUserInteractionEnabled = false
        addNewPass.text = "Add New Pass"
        addNewPass.font = Font.semibold.withSize(size: 18)
        addNewPass.widthAnchor.constraint(equalToConstant: 130).isActive = true
        addNewPass.leftAnchor.constraint(equalTo: addPassButton.leftAnchor, constant: 40).isActive = true
        addNewPass.centerYAnchor.constraint(equalTo: addPassButton.centerYAnchor).isActive = true
        
        let plusView = UIView()
        addPassButton.addSubview(plusView)
        plusView.translatesAutoresizingMaskIntoConstraints = false
        plusView.isUserInteractionEnabled = false
        plusView.backgroundColor = Color.action
        plusView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        plusView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        plusView.centerYAnchor.constraint(equalTo: addPassButton.centerYAnchor).isActive = true
        plusView.leftAnchor.constraint(equalTo: addNewPass.rightAnchor, constant: 30).isActive = true
        plusView.layer.cornerRadius = 10
        
        let plusSign = UIImageView()
        plusView.addSubview(plusSign)
        plusSign.translatesAutoresizingMaskIntoConstraints = false
        plusSign.tintColor = .white
        plusSign.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: UIImage.SymbolWeight.semibold))
        plusSign.widthAnchor.constraint(equalToConstant: 20).isActive = true
        plusSign.heightAnchor.constraint(equalToConstant: 20).isActive = true
        plusSign.centerXAnchor.constraint(equalTo: plusView.centerXAnchor).isActive = true
        plusSign.centerYAnchor.constraint(equalTo: plusView.centerYAnchor).isActive = true
        
        let myPassesLabel = UILabel()
        view.addSubview(myPassesLabel)
        myPassesLabel.text = "My Passes"
        myPassesLabel.font = Font.semibold.withSize(size: 16)
        myPassesLabel.translatesAutoresizingMaskIntoConstraints = false
        myPassesLabel.topAnchor.constraint(equalTo: addPassButton.bottomAnchor, constant: 50).isActive = true
        myPassesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        layoutUI()
    }


}


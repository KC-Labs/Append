//
//  CollectionReusableView.swift
//  append
//
//  Created by Patrick Cui on 9/11/21.
//

import UIKit
import Toast_Swift

class HeaderView: UICollectionReusableView {
    
    static let identifier = "homeHeaderView"
    public var addPassFunc : (() -> Void)?
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.image = UIImage(named: "logo")
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    private let addPassButton: UIButton = {
        let addPassButton = UIButton()
        // button label
        let addNewPass: UILabel = {
            let addNewPass = UILabel()
            addNewPass.translatesAutoresizingMaskIntoConstraints = false
            addNewPass.isUserInteractionEnabled = false
            addNewPass.text = "Add New Pass"
            addNewPass.font = Font.semibold.withSize(size: 18.s)
            return addNewPass
        }()
        addPassButton.addSubview(addNewPass)
        addNewPass.widthAnchor.constraint(equalToConstant: 130.s).isActive = true
        addNewPass.leftAnchor.constraint(equalTo: addPassButton.leftAnchor, constant: 40.s).isActive = true
        addNewPass.centerYAnchor.constraint(equalTo: addPassButton.centerYAnchor).isActive = true
        // plus sign view
        let plusView: UIView = {
            let plusView = UIView()
            // plus sign icon
            let plusSign: UIImageView = {
                let plusSign = UIImageView()
                plusSign.translatesAutoresizingMaskIntoConstraints = false
                plusSign.tintColor = .white
                plusSign.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16.s, weight: UIImage.SymbolWeight.semibold))
                return plusSign
            }()
            plusView.addSubview(plusSign)
            plusSign.widthAnchor.constraint(equalToConstant: 20.s).isActive = true
            plusSign.heightAnchor.constraint(equalToConstant: 20.s).isActive = true
            plusSign.centerXAnchor.constraint(equalTo: plusView.centerXAnchor).isActive = true
            plusSign.centerYAnchor.constraint(equalTo: plusView.centerYAnchor).isActive = true
            plusView.translatesAutoresizingMaskIntoConstraints = false
            plusView.isUserInteractionEnabled = false
            plusView.backgroundColor = Color.action
            plusView.layer.cornerRadius = 10.s
            return plusView
        }()
        addPassButton.addSubview(plusView)
        plusView.widthAnchor.constraint(equalToConstant: 40.s).isActive = true
        plusView.heightAnchor.constraint(equalToConstant: 40.s).isActive = true
        plusView.centerYAnchor.constraint(equalTo: addPassButton.centerYAnchor).isActive = true
        plusView.leftAnchor.constraint(equalTo: addNewPass.rightAnchor, constant: 30).isActive = true
        // general button autolayout
        addPassButton.translatesAutoresizingMaskIntoConstraints = false
        addPassButton.addTarget(self, action: #selector(addPass), for: .touchUpInside)
        addPassButton.backgroundColor = Color.card
        addPassButton.layer.cornerRadius = 10.s
        addPassButton.layer.shadowOffset = CGSize(width: 0, height: 5.s)
        addPassButton.layer.shadowColor = UIColor.black.cgColor
        addPassButton.layer.shadowRadius = 15.s
        addPassButton.layer.shadowOpacity = 0.25
        return addPassButton
    }()
    
    private let myPassesLabel: UILabel = {
        let myPassesLabel = UILabel()
        myPassesLabel.text = "My Passes"
        myPassesLabel.font = Font.semibold.withSize(size: 16.s)
        myPassesLabel.translatesAutoresizingMaskIntoConstraints = false
        return myPassesLabel
    }()
    
    
    @objc func addPass(sender: UIButton) {
        sender.showAnimation {
            // send notification to parent viewcontroller to push camera
            NotificationCenter.default.post(name: .pushCamera, object: nil)
        }
    }
    
    func layoutUI() {
        addSubview(logoView)
        logoView.widthAnchor.constraint(equalToConstant: 120.s).isActive = true
        logoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addSubview(addPassButton)
        addPassButton.widthAnchor.constraint(equalToConstant: 260.s).isActive = true
        addPassButton.heightAnchor.constraint(equalToConstant: 70.s).isActive = true
        addPassButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addPassButton.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 30.s).isActive = true
        addSubview(myPassesLabel)
        myPassesLabel.topAnchor.constraint(equalTo: addPassButton.bottomAnchor, constant: 50.s).isActive = true
        myPassesLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

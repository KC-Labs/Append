//
//  PassDetail.swift
//  append
//
//  Created by Patrick Cui on 9/11/21.
//

import UIKit
import PassKit

class PassDetail: UIViewController {
    
    var data: Pass!
    private let backArrow = IconButton.init(symbol: "arrow.backward", color: UIColor.white)
    private let iconView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(48)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.bold.withSize(size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.6
        return label
    }()
    private let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.action
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        button.layer.shadowRadius = 10
        let img = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: UIImage.SymbolWeight.semibold))
        button.setImage(img, for: .normal)
        button.tintColor = UIColor.white
        return button
    }()
    private var preview = UIView()
    private let addToWallet = PKAddPassButton(addPassButtonStyle: PKAddPassButtonStyle.blackOutline)
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = Color.destructive.cgColor
        button.setTitle("Delete Pass", for: .normal)
        button.titleLabel?.font = Font.medium.withSize(size: 14)
        button.setTitleColor(Color.destructive, for: .normal)
        return button
    }()
    
    @objc func back() {
        dismiss(animated: true)
    }
    
    @objc func edit(sender: UIButton) {
        sender.showAnimation {
            
        }
    }
    
    @objc func deletePass(sender: UIButton) {
        sender.showAnimation {
            
        }
    }
    
    
    func layoutUI() {
        view.addSubview(backArrow)
        backArrow.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        backArrow.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 48).isActive = true
        backArrow.widthAnchor.constraint(equalToConstant: 24).isActive = true
        backArrow.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(iconView)
        iconView.text = data.icon
        iconView.topAnchor.constraint(equalTo: backArrow.bottomAnchor, constant: 36).isActive = true
        iconView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 48).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(titleLabel)
        titleLabel.text = data.title
        titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 6).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 48).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        view.addSubview(editButton)
        editButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        editButton.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        editButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        editButton.addTarget(self, action: #selector(edit), for: .touchDown)
        preview = data.preview()
        view.addSubview(preview)
        preview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 36).isActive = true
        preview.widthAnchor.constraint(equalToConstant: 280).isActive = true
        preview.heightAnchor.constraint(equalToConstant: 330).isActive = true
        preview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        preview.layer.shadowOpacity = 0.15
        preview.layer.shadowColor = UIColor.black.cgColor
        preview.layer.shadowOffset = CGSize(width: 0, height: 10)
        preview.layer.shadowRadius = 10
        view.addSubview(addToWallet)
        addToWallet.translatesAutoresizingMaskIntoConstraints = false
        addToWallet.topAnchor.constraint(equalTo: preview.bottomAnchor, constant: 36).isActive = true
        addToWallet.centerXAnchor.constraint(equalTo: preview.centerXAnchor).isActive = true
        addToWallet.widthAnchor.constraint(equalToConstant: 200).isActive = true
        view.addSubview(deleteButton)
        deleteButton.topAnchor.constraint(equalTo: addToWallet.bottomAnchor, constant: 16).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: addToWallet.heightAnchor).isActive = true
        deleteButton.addTarget(self, action: #selector(deletePass), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }

}

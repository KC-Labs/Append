//
//  PassDetail.swift
//  append
//
//  Created by Patrick Cui on 9/11/21.
//

import UIKit
import PassKit
import SafariServices

class PassDetail: UIViewController {
    
    var data: Pass! {
        didSet {
            preview = data.preview()
        }
    }
    private let backArrow = IconButton.init(symbol: "arrow.backward", color: UIColor.white)
    private let iconView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(48.s)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.bold.withSize(size: 24.s)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.6
        return label
    }()
    private let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.action
        button.layer.cornerRadius = 10.s
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 10.s)
        button.layer.shadowRadius = 10.s
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
        button.layer.cornerRadius = 10.s
        button.layer.borderWidth = 2.s
        button.layer.borderColor = Color.destructive.cgColor
        button.setTitle("Delete Pass", for: .normal)
        button.titleLabel?.font = Font.medium.withSize(size: 16.s)
        button.setTitleColor(Color.destructive, for: .normal)
        return button
    }()
    
    @objc func back() {
        dismiss(animated: true)
    }
    
    @objc func edit(sender: UIButton) {
        sender.showAnimation {
            let vc = ConfigurePass()
            vc.currentPassEditing = self.data
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
    
    @objc func deletePass(sender: UIButton) {
        sender.showAnimation {
            let ac = UIAlertController(title: "Delete this pass?", message: "You cannot undo this action once it is complete.", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                placeholderData.removeAll { e in
                    e.title == self.data.title
                }
                self.dismiss(animated: true) {
                    NotificationCenter.default.post(name: NSNotification.Name(Home.toastDeleted), object: nil)
                }
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(ac, animated: true)
        }
    }
    
    func showWalletPage() {
        
        func process(walletLink: String) -> Void {
            print("generatePass completed")
            print("walletLink: " + walletLink)
            
            // open in safari
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let safariVC = SFSafariViewController(url: URL(string: walletLink)!, configuration: config)
            present(safariVC, animated: true)
        }
        
        let indexOfColor = Color.customColors.firstIndex{$0 == data.color}!
        print("found color index: " + indexOfColor.description)
        
        PSInterface.generatePass(whenCompleted: process, mainText: data.title, subText: data.note!, barcodeData: data.barcodeData!, colorIndex: indexOfColor)
    }
    
    @objc func addToWalletAction(sender: UIButton) {
        sender.showAnimation {
            //TODO: ADD TO WALLET HERE
            self.showWalletPage()
        }
    }
    
    
    func layoutUI() {
        view.addSubview(backArrow)
        backArrow.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.s).isActive = true
        backArrow.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 48.s).isActive = true
        backArrow.widthAnchor.constraint(equalToConstant: 24.s).isActive = true
        backArrow.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(iconView)
        iconView.text = data.icon
        iconView.topAnchor.constraint(equalTo: backArrow.bottomAnchor, constant: 36).isActive = true
        iconView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 48.s).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 50.s).isActive = true
        view.addSubview(titleLabel)
        titleLabel.text = data.title
        titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 6).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 48.s).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 220.s).isActive = true
        view.addSubview(editButton)
        editButton.widthAnchor.constraint(equalToConstant: 40.s).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 40.s).isActive = true
        editButton.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        editButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        editButton.addTarget(self, action: #selector(edit), for: .touchDown)
        view.addSubview(preview)
        preview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 36).isActive = true
        preview.widthAnchor.constraint(equalToConstant: 280.s).isActive = true
        preview.heightAnchor.constraint(equalToConstant: 330.s).isActive = true
        preview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        preview.layer.shadowOpacity = 0.15
        preview.layer.shadowColor = UIColor.black.cgColor
        preview.layer.shadowOffset = CGSize(width: 0, height: 5.s)
        preview.layer.shadowRadius = 5.s
        view.addSubview(addToWallet)
        addToWallet.translatesAutoresizingMaskIntoConstraints = false
        addToWallet.topAnchor.constraint(equalTo: preview.bottomAnchor, constant: 36.s).isActive = true
        addToWallet.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToWallet.widthAnchor.constraint(equalToConstant: 200.s).isActive = true
        view.addSubview(deleteButton)
        deleteButton.topAnchor.constraint(equalTo: addToWallet.bottomAnchor, constant: 16.s).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 200.s).isActive = true
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

//
//  Customization.swift
//  append
//
//  Created by Patrick Cui on 9/12/21.
//

import UIKit
import SafariServices
import UIKit
import PassKit

class Customization: UIViewController {
    
    var isFinished = false
    var isEdit: Bool!
    var pass: Pass! {
        didSet {
            preview = pass.preview()
        }
    }
    var oldPass: Pass?
    private let titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.semibold.withSize(size: 18)
        label.textAlignment = .center
        return label
    }()
    private let backButton = IconButton(symbol: "arrow.backward", color: UIColor.white.withAlphaComponent(0.5))
    private var nextButton = IconButton(symbol: "checkmark", color: Color.action)
    private let icon: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.titleLabel?.font = b.titleLabel!.font.withSize(48)
        b.titleLabel?.adjustsFontSizeToFitWidth = true
        return b
    }()
    private var preview = UIView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let addToWallet = PKAddPassButton(addPassButtonStyle: PKAddPassButtonStyle.blackOutline)
    private let backToHome: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.s
        button.layer.borderWidth = 2.s
        button.layer.borderColor = Color.action.cgColor
        button.setTitle("Back to Home", for: .normal)
        button.titleLabel?.font = Font.medium.withSize(size: 16.s)
        button.setTitleColor(Color.action, for: .normal)
        return button
    }()
    
    
    func showWalletPage() {
        print("showWalletPage ran")
        func process(walletLink: String) -> Void {
            print("generatePass completed")
            print("walletLink: " + walletLink)
            
            // open in safari
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let safariVC = SFSafariViewController(url: URL(string: walletLink)!, configuration: config)
            present(safariVC, animated: true)
        }
        
        let indexOfColor = Color.customColors.firstIndex{$0 == pass.color}!
        print("found color index: " + indexOfColor.description)
        
        PSInterface.generatePass(whenCompleted: process, mainText: pass.title, subText: pass.note!, barcodeData: pass.barcodeData!, colorIndex: indexOfColor)
    }
    
    @objc func back() {
        if !isFinished {
            dismiss(animated: true)
        }
    }
    
    @objc func goHome() {
        view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @objc func finish() {
        if isFinished {
            view.window?.rootViewController?.dismiss(animated: true)
        } else {
            isFinished = true
            oldPass?.update(with: pass)
            myPasses.append(pass)
            UIView.animate(withDuration: 0.2) {
                self.collectionView.alpha = 0
                self.backButton.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.addToWallet.alpha = 1
                    self.backToHome.alpha = 1
                }
            }
            backButton.isEnabled = false
            addToWallet.isEnabled = true
            backToHome.isEnabled = true
            titleText.text = "Your Pass is Ready"
            
            // fade in the other two views
        }
    }
    
    @objc func addToWalletAction(sender: UIButton) {
        print("test")
        sender.showAnimation {
            //TODO: ADD TO WALLET HERE
            print("this is being ran")
            self.showWalletPage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        view.addSubview(collectionView)
        view.addSubview(titleText)
        titleText.text = (isFinished) ? "Your Pass is Ready" : "Customize"
        titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleText.widthAnchor.constraint(equalToConstant: 200.s).isActive = true
        view.addSubview(backButton)
        backButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.s).isActive = true
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(nextButton)
        nextButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40.s).isActive = true
        nextButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        nextButton.updateColor(to: Color.action)
        view.addSubview(preview)
        preview.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 36).isActive = true
        preview.widthAnchor.constraint(equalToConstant: 280.s).isActive = true
        preview.heightAnchor.constraint(equalToConstant: 330.s).isActive = true
        preview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        preview.layer.shadowOpacity = 0.15
        preview.layer.shadowColor = UIColor.black.cgColor
        preview.layer.shadowOffset = CGSize(width: 0, height: 5.s)
        preview.layer.shadowRadius = 5.s
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "colorChoices")
        collectionView.backgroundColor = Color.bg
        collectionView.allowsMultipleSelection = false
        addToWallet.addTarget(self, action: #selector(addToWalletAction), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.widthAnchor.constraint(equalToConstant: 240.s).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 180.s).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: preview.bottomAnchor, constant: 36.s).isActive = true
        view.addSubview(addToWallet)
        addToWallet.translatesAutoresizingMaskIntoConstraints = false
        addToWallet.topAnchor.constraint(equalTo: preview.bottomAnchor, constant: 50.s).isActive = true
        addToWallet.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToWallet.widthAnchor.constraint(equalToConstant: 200.s).isActive = true
        addToWallet.alpha = 0
        addToWallet.isEnabled = false
        view.addSubview(backToHome)
        backToHome.topAnchor.constraint(equalTo: addToWallet.bottomAnchor, constant: 16.s).isActive = true
        backToHome.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backToHome.widthAnchor.constraint(equalToConstant: 200.s).isActive = true
        backToHome.heightAnchor.constraint(equalTo: addToWallet.heightAnchor).isActive = true
        backToHome.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        backToHome.alpha = 0
        addToWallet.isEnabled = false
    }
    
}

extension Customization: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Color.customColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorChoices", for: indexPath)
        cell.backgroundColor = Color.customColors[indexPath.item]
        cell.layer.cornerRadius = 32.s
        if pass.color == cell.backgroundColor {
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = UIColor.white.cgColor
        } else {
            cell.layer.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64.s, height: 64.s)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pass.color = Color.customColors[indexPath.item]
        collectionView.reloadData()
        preview.removeFromSuperview()
        preview = pass.preview()
        view.addSubview(preview)
        preview.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 36).isActive = true
        preview.widthAnchor.constraint(equalToConstant: 280.s).isActive = true
        preview.heightAnchor.constraint(equalToConstant: 330.s).isActive = true
        preview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        preview.layer.shadowOpacity = 0.15
        preview.layer.shadowColor = UIColor.black.cgColor
        preview.layer.shadowOffset = CGSize(width: 0, height: 5.s)
        preview.layer.shadowRadius = 5.s
        
    }
    
}

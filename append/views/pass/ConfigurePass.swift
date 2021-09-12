//
//  ConfigurePass.swift
//  append
//
//  Created by Jimmy Kang on 9/11/21.
//

import Foundation
import AVFoundation
import UIKit
import Vision
import EmojiPicker

class ConfigurePass: UIViewController {
    
    public var codeData: String?
    public var codeSymbology: VNBarcodeSymbology?
    var didSetEmoji = false
    var isTitleOversized = false  {
        didSet {
            titleField.isScrollEnabled = isTitleOversized
        }
    }
    var isNotesOversized = false {
        didSet {
            notesField.isScrollEnabled = isNotesOversized
        }
    }
    var currentPassEditing: Pass? {
        didSet {
            didSetEmoji = true
            pendingPass = currentPassEditing!.copy()
        }
    }
    var pendingPass = Pass(icon: "", title: "", color: Color.customColors[2], type: "", note: nil)
    var tap = UITapGestureRecognizer()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.semibold.withSize(size: 18.s)
        label.textAlignment = .center
        return label
    }()
    private let cancelButton = IconButton(symbol: "xmark", color: Color.destructive)
    private var nextButton = IconButton(symbol: "arrow.forward", color: UIColor.white.withAlphaComponent(0.5))
    private let icon: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.titleLabel?.font = b.titleLabel!.font.withSize(48.s)
        b.titleLabel?.adjustsFontSizeToFitWidth = true
        return b
    }()
    private let addIconText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.semibold.withSize(size: 13.s)
        label.textColor = Color.action
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let titleField = UITextView()
    private let categoryField: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.titleLabel?.font = Font.semibold.withSize(size: 14.s)
        b.titleLabel?.textColor = Color.action
        b.titleLabel?.adjustsFontSizeToFitWidth = true
        b.titleLabel?.textAlignment = .left
        return b
    }()
    private let notesField = UITextView()
    
    @objc func back() {
        dismiss(animated: true)
    }
    
    @objc func goNext() {
        validateForm()
        print("codeData: " + codeData!)
        let barcode: String = codeData!
        let title = pendingPass.title
        let text = pendingPass.note ?? ""
        
        func process(walletLink: String) -> Void {
            print("generatePass completed")
            print("walletLink: " + walletLink)
        }
        let ans = PSInterface.generatePass(whenCompleted: process, mainText: title, subText: text, barcodeData: barcode)
        
//        // testing code
//        let imageTest = ImageTest()
//        self.present(imageTest, animated: true)
//        
    }
    
    // do your validation here
    @objc func validateForm() {
        //TODO: check if same name exists
        let vc = Customization()
        vc.isEdit = true
        vc.pass = pendingPass
        vc.oldPass = currentPassEditing
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func pickEmoji() {
        let evc = EmojiPicker.viewController
        evc.delegate = self
        evc.sourceRect = CGRect(x: 40.s, y: 25.s, width: icon.frame.midX, height: icon.frame.midY)
        evc.size = CGSize(width: 200.s, height: 250.s)
        evc.isDarkMode = true
        evc.dismissAfterSelected = true
        present(evc, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func chooseCategory() {
        let vc = ChooseCategory()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func shouldAllowNext() -> Bool {
        return !pendingPass.title.isEmpty && !pendingPass.type.isEmpty
    }
    
    func layoutUI() {
        view.addSubview(titleText)
        titleText.text = (currentPassEditing == nil) ? "New Pass" : "Edit Pass"
        titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.s).isActive = true
        titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleText.widthAnchor.constraint(equalToConstant: 150.s).isActive = true
        view.addSubview(cancelButton)
        cancelButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.s).isActive = true
        cancelButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(nextButton)
        nextButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40.s).isActive = true
        nextButton.addTarget(self, action: #selector(validateForm), for: .touchUpInside)
        nextButton.updateColor(to: (shouldAllowNext()) ? Color.action : UIColor.white.withAlphaComponent(0.5))
        view.addSubview(icon)
        icon.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 32.s).isActive = true
        icon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.s).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50.s).isActive = true
        icon.addTarget(self, action: #selector(pickEmoji), for: .touchUpInside)
        icon.setTitle(pendingPass.icon != "" ? pendingPass.icon : "😃", for: .normal)
        view.addSubview(addIconText)
        addIconText.text = (didSetEmoji) ? "Edit Icon" : "Set Icon"
        addIconText.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: -10.s).isActive = true
        addIconText.centerXAnchor.constraint(equalTo: icon.centerXAnchor).isActive = true
        addIconText.widthAnchor.constraint(equalToConstant: 40.s).isActive = true
        view.addSubview(titleField)
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.s).isActive = true
        titleField.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: 40.s).isActive = true
        titleField.widthAnchor.constraint(equalToConstant: 280.s).isActive = true
        titleField.topAnchor.constraint(equalTo: addIconText.bottomAnchor, constant: 6).isActive = true
        view.addSubview(categoryField)
        categoryField.setTitle( pendingPass.type != "" ? pendingPass.type : "Choose Category", for: .normal)
        categoryField.setTitleColor(Color.action, for: .normal)
        categoryField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 12.s).isActive = true
        categoryField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45.s).isActive = true
        categoryField.widthAnchor.constraint(lessThanOrEqualToConstant: 200.s).isActive = true
        categoryField.addTarget(self, action: #selector(chooseCategory), for: .touchUpInside)
        view.addSubview(notesField)
        notesField.translatesAutoresizingMaskIntoConstraints = false
        notesField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.s).isActive = true
        notesField.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: 40.s).isActive = true
        notesField.widthAnchor.constraint(equalToConstant: 280.s).isActive = true
        notesField.topAnchor.constraint(equalTo: categoryField.bottomAnchor, constant: 16.s).isActive = true
    }
    
    func setUpTextViews() {
        titleField.isEditable = true
        titleField.delegate = self
        titleField.text = currentPassEditing?.title ?? "Enter Pass Name"
        titleField.backgroundColor = Color.bg
        titleField.textAlignment = .left
        titleField.font = Font.bold.withSize(size: 24)
        titleField.textColor = (currentPassEditing == nil) ? UIColor.lightGray : UIColor.white
        titleField.isScrollEnabled = false
        notesField.isEditable = true
        notesField.delegate = self
        notesField.text = currentPassEditing?.note ?? "Add Description (Number, Dates, Reminders)"
        notesField.backgroundColor = Color.bg
        notesField.textAlignment = .left
        notesField.font = Font.regular.withSize(size: 14)
        notesField.textColor = (currentPassEditing?.note == nil) ? UIColor.lightGray : UIColor.white
        notesField.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        setUpTextViews()
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.isEnabled = false
        view.addGestureRecognizer(tap)
        pendingPass.barcodeData = codeData
        pendingPass.barcodeMetaData = codeSymbology?.rawValue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
        if isTitleOversized {
            titleField.heightAnchor.constraint(equalToConstant: 60.s).isActive = true
        } else {
            titleField.heightAnchor.constraint(equalToConstant: 60.s).isActive = false
        }
        if isNotesOversized {
            notesField.heightAnchor.constraint(equalToConstant: 120.s).isActive = true
        } else {
            notesField.heightAnchor.constraint(equalToConstant: 120.s).isActive = false
        }
    }
}

extension ConfigurePass: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        tap.isEnabled = true
        if textView == titleField && titleField.textColor == UIColor.lightGray {
            titleField.text = nil
            titleField.textColor = UIColor.white
        }
        if textView == notesField && notesField.textColor == UIColor.lightGray {
            notesField.text = nil
            notesField.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        tap.isEnabled = false
        if textView == titleField && titleField.text.isEmpty {
            titleField.text = "Enter Pass Name"
            titleField.textColor = UIColor.lightGray
            
        }
        if textView == notesField && notesField.text.isEmpty {
            notesField.text = "Add Description (Number, Dates, Reminders)"
            notesField.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == titleField && textView.contentSize.height >= 60.s {
            isTitleOversized = true
        } else {
            isTitleOversized = false
        }
        if textView == notesField && textView.contentSize.height >= 120.s {
            isNotesOversized = true
        } else {
            isNotesOversized = false
        }
        if textView == titleField {
            pendingPass.title = titleField.text
        } else {
            pendingPass.note = notesField.text
        }
    }
    
}

extension ConfigurePass: EmojiPickerViewControllerDelegate {
    func emojiPickerViewController(_ controller: EmojiPickerViewController, didSelect emoji: String) {
        pendingPass.icon = emoji
        icon.setTitle(pendingPass.icon, for: .normal)
    }
}

extension ConfigurePass: CategoryDelegate {
    func onSelected(category: String) {
        pendingPass.type = category
        categoryField.setTitle(pendingPass.type, for: .normal)
    }
}

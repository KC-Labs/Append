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
    var pendingPass = Pass(icon: "", title: "", color: Color.card, type: "", note: nil)
    var tap = UITapGestureRecognizer()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.semibold.withSize(size: 18)
        label.textAlignment = .center
        return label
    }()
    private let cancelButton = IconButton(symbol: "xmark", color: Color.destructive)
    private var nextButton = IconButton(symbol: "arrow.forward", color: UIColor.white.withAlphaComponent(0.5))
    private let icon: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.titleLabel?.font = b.titleLabel!.font.withSize(48)
        b.titleLabel?.adjustsFontSizeToFitWidth = true
        return b
    }()
    private let addIconText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.semibold.withSize(size: 13)
        label.textColor = Color.action
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let titleField = UITextView()
    private let categoryField: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.titleLabel?.font = Font.semibold.withSize(size: 14)
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
        let text = pendingPass.note
        let ans = PSInterface.generatePass(whenCompleted: , mainText: "main test", subText: "sub test", barcodeData: "12345")
        print("received ans: " + ans)
    }
    
    // do your validation here
    @objc func validateForm() {
       
    }
    
    @objc func pickEmoji() {
        let evc = EmojiPicker.viewController
        evc.delegate = self
        evc.sourceRect = CGRect(x: 40, y: 25, width: icon.frame.midX, height: icon.frame.midY)
        evc.size = CGSize(width: 200, height: 250)
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
        titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleText.widthAnchor.constraint(equalToConstant: 150).isActive = true
        view.addSubview(cancelButton)
        cancelButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        cancelButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(nextButton)
        nextButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        nextButton.updateColor(to: (shouldAllowNext()) ? Color.action : UIColor.white.withAlphaComponent(0.5))
        view.addSubview(icon)
        icon.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 32).isActive = true
        icon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        icon.addTarget(self, action: #selector(pickEmoji), for: .touchUpInside)
        icon.setTitle(pendingPass.icon != "" ? pendingPass.icon : "😃", for: .normal)
        view.addSubview(addIconText)
        addIconText.text = (didSetEmoji) ? "Edit Icon" : "Set Icon"
        addIconText.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: -10).isActive = true
        addIconText.centerXAnchor.constraint(equalTo: icon.centerXAnchor).isActive = true
        addIconText.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.addSubview(titleField)
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        titleField.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: 40).isActive = true
        titleField.widthAnchor.constraint(equalToConstant: 280).isActive = true
        titleField.topAnchor.constraint(equalTo: addIconText.bottomAnchor, constant: 6).isActive = true
        view.addSubview(categoryField)
        categoryField.setTitle( pendingPass.type != "" ? pendingPass.type : "Choose Category", for: .normal)
        categoryField.setTitleColor(Color.action, for: .normal)
        categoryField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 12).isActive = true
        categoryField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45).isActive = true
        categoryField.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        categoryField.addTarget(self, action: #selector(chooseCategory), for: .touchUpInside)
        view.addSubview(notesField)
        notesField.translatesAutoresizingMaskIntoConstraints = false
        notesField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        notesField.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: 40).isActive = true
        notesField.widthAnchor.constraint(equalToConstant: 280).isActive = true
        notesField.topAnchor.constraint(equalTo: categoryField.bottomAnchor, constant: 16).isActive = true
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
        if isTitleOversized {
            titleField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        } else {
            titleField.heightAnchor.constraint(equalToConstant: 60).isActive = false
        }
        if isNotesOversized {
            notesField.heightAnchor.constraint(equalToConstant: 120).isActive = true
        } else {
            notesField.heightAnchor.constraint(equalToConstant: 120).isActive = false
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
        if textView == titleField && textView.contentSize.height >= 60 {
            isTitleOversized = true
        } else {
            isTitleOversized = false
        }
        if textView == notesField && textView.contentSize.height >= 120{
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

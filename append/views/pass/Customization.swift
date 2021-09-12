//
//  Customization.swift
//  append
//
//  Created by Patrick Cui on 9/12/21.
//

import UIKit

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
    
    @objc func back() {
        if !isFinished {
            dismiss(animated: true)
        }
    }
    
    @objc func finish() {
        if isFinished {
            // go home
        } else {
            isFinished = true
            // update things
            // save to cache
            // append to array
            // fade out color palletee
            // fade in the other two views
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.widthAnchor.constraint(equalToConstant: 240.s).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 180.s).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: preview.bottomAnchor, constant: 36.s).isActive = true
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

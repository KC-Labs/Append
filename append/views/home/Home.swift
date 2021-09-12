//
//  ViewController.swift
//  append
//
//  Created by Patrick Cui on 9/10/21.
//

import UIKit
import Toast_Swift

class Home: UIViewController {
    
    static let toastDeleted = "showDeletedToastMessage"
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    @objc func showDeleteToast() {
        view.makeToast("Pass Deleted")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatRatio = view.bounds.width / 375
        NotificationCenter.default.addObserver(self, selector: #selector(showDeleteToast), name: NSNotification.Name(Home.toastDeleted), object: nil)
        collectionView.register(SavedPassesCell.self, forCellWithReuseIdentifier: SavedPassesCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Color.bg
        view.addSubview(collectionView)
        NotificationCenter.default.addObserver(self, selector: #selector(pushCamera(_:)), name:
                                                .pushCamera, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
        if (placeholderData.isEmpty) {
            let icon: UILabel = {
                let l = UILabel()
                l.translatesAutoresizingMaskIntoConstraints = false
                l.text = "📭"
                l.font = Font.medium.withSize(size: 54.s)
                l.textAlignment = .center
                return l
            }()
            let label: UILabel = {
                let l = UILabel()
                l.translatesAutoresizingMaskIntoConstraints = false
                l.text = "No saved passes"
                l.font = Font.medium.withSize(size: 14.s)
                l.textAlignment = .center
                return l
            }()
            let bgView = UIView()
            bgView.translatesAutoresizingMaskIntoConstraints = false
            bgView.addSubview(icon)
            bgView.addSubview(label)
            collectionView.backgroundView = bgView
            icon.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
            icon.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
            icon.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
            label.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10.s).isActive = true
            label.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
            bgView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
            bgView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
            bgView.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
            bgView.heightAnchor.constraint(equalTo: collectionView.heightAnchor).isActive = true
        } else {
            collectionView.backgroundView = nil
        }}
    
    // pushes the camera view

    @objc func pushCamera(_ notification: Notification) {
        let camera = Camera()
        self.present(camera, animated:true)
    }
    
}

extension Home: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeholderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedPassesCell.identifier, for: indexPath) as! SavedPassesCell
        cell.data = placeholderData[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {  
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath)
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250.s)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110.s, height: 110.s)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 60.s, bottom: 100.s, right: 60.s)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40.s
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PassDetail()
        vc.modalPresentationStyle = .fullScreen
        vc.data = placeholderData[indexPath.item]
        present(vc, animated: true)
    }
    
    
}

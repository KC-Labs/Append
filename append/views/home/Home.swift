//
//  ViewController.swift
//  append
//
//  Created by Patrick Cui on 9/10/21.
//

import UIKit

class Home: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let placeholderData: [Pass] = [
        Pass(icon: "🏀", title: "Gym Membership", color: Color.customColors.first!, type: "Membership Card", note: "Member #: 1234 5678 1213"),
        Pass(icon: "🎨", title: "Art Supply Shop", color: Color.customColors.first!, type: "Membership Card", note: nil),
        Pass(icon: "💻", title: "Laptop ID", color: Color.customColors.first!, type: "Membership Card", note: nil),
        Pass(icon: "🐻", title: "Cal 1 Card", color: Color.customColors.first!, type: "Membership Card", note: nil),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 60, bottom: 100, right: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PassDetail()
        vc.modalPresentationStyle = .fullScreen
        vc.data = placeholderData[indexPath.item]
        present(vc, animated: true)
    }
    
    
}

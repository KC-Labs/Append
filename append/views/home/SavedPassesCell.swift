//
//  SavedPassesCell.swift
//  append
//
//  Created by Patrick Cui on 9/11/21.
//

import UIKit

class SavedPassesCell: UICollectionViewCell {
    static let identifier = "homeIdentifier"
    
    let icon: UILabel = {
        let iconLabel = UILabel()
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.font = iconLabel.font.withSize(48.s)
        iconLabel.adjustsFontSizeToFitWidth = true
        return iconLabel
    }()
    
    let title: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font.bold.withSize(size: 12.s)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        return titleLabel
    }()
    
    var data: Pass? {
        didSet {
            guard let data = data else {return}
            icon.text = data.icon
            title.text = data.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = Color.card
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 10.s)
        contentView.layer.shadowRadius = 10.s
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(icon)
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 10.s).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50.s).isActive = true
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(title)
        title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 5.s).isActive = true
        title.widthAnchor.constraint(equalToConstant: 75.s).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CategoryCell.swift
//  append
//
//  Created by Patrick Cui on 9/12/21.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    static let identifier = "CategoryCellForPasses"
    
    var category: String! {
        didSet {
            categoryLabel.text = category
        }
    }

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.semibold.withSize(size: 18)
        label.textColor = Color.action
        label.textAlignment = .center
        return label
    }()
    
    @objc func selectCategory(sender: UIButton) {
        sender.showAnimation {
            print("yes")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(categoryLabel)
        categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

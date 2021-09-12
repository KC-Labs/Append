//
//  elements.swift
//  append
//
//  Created by Patrick Cui on 9/11/21.
//

import UIKit

class IconButton: UIButton {
    
    var symbol: String?
    var color: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(symbol: String, color: UIColor) {
        self.init()
        self.symbol = symbol
        self.color = color
        self.translatesAutoresizingMaskIntoConstraints = false
        setUp()
    }

    func setUp() {
        guard symbol != nil && color != nil else {return}
        let icon = UIImage(systemName: symbol!, withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.semibold))
        self.setImage(icon, for: .normal)
        self.tintColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

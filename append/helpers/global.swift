//
//  Colors.swift
//  append
//
//  Created by Patrick Cui on 9/10/21.
//

import Foundation
import UIKit

struct Color {
    static let bg = UIColor(red: 47 / 255, green: 52 / 255, blue: 55 / 255, alpha: 1)
    static let card = UIColor(red: 63 / 255, green: 68 / 255, blue: 71 / 255, alpha: 1)
    static let action = UIColor(red: 47 / 255, green: 170 / 255, blue: 220 / 255, alpha: 1)
    static let destructive = UIColor(red: 235 / 255, green: 87 / 255, blue: 87 / 255, alpha: 1)
    static let customColors = [
        UIColor(red: 160 / 255, green: 93 / 255, blue: 89 / 255, alpha: 1),
        UIColor(red: 109 / 255, green: 89 / 255, blue: 144 / 255, alpha: 1),
        UIColor(red: 73 / 255, green: 113 / 255, blue: 136 / 255, alpha: 1),
        UIColor(red: 72 / 255, green: 120 / 255, blue: 113 / 255, alpha: 1),
        UIColor(red: 159 / 255, green: 145 / 255, blue: 76 / 255, alpha: 1),
        UIColor.black
    ]
}

struct Font {
    struct regular {
        static func withSize(size: CGFloat) -> UIFont {
            return UIFont(name: "SFProText-Regular", size: size)!
        }
    }
    struct medium {
        static func withSize(size: CGFloat) -> UIFont {
            return UIFont(name: "SFProText-Medium", size: size)!
        }
    }
    struct semibold {
        static func withSize(size: CGFloat) -> UIFont {
            return UIFont(name: "SFProText-Semibold", size: size)!
        }
    }
    struct bold {
        static func withSize(size: CGFloat) -> UIFont {
            return UIFont(name: "SFProText-Bold", size: size)!
        }
    }
    struct ny {
        static func withSize(size: CGFloat) -> UIFont {
            return UIFont(name: "New York Large", size: size)!
        }
    }
    
}

var placeholderData: [Pass] = [
    Pass(icon: "🏀", title: "Gym Membership", color: Color.customColors.first!, type: "Membership Card", note: "Member #: 1234 5678 1213"),
    Pass(icon: "🎨", title: "Art Supply Shop", color: Color.customColors.first!, type: "Membership Card", note: nil),
    Pass(icon: "💻", title: "Laptop ID", color: Color.customColors.first!, type: "Membership Card", note: nil),
    Pass(icon: "🐻", title: "Cal 1 Card", color: Color.customColors.first!, type: "Membership Card", note: nil),
]

var floatRatio: CGFloat = 1
var doubleRatio: Double = 1

extension CGFloat {
    var s: CGFloat { return self * floatRatio}
}

extension Double {
    var s: CGFloat { return CGFloat(self) * floatRatio}
}

extension Int {
    var s: CGFloat { return CGFloat(self) * floatRatio}
}


// passslot access details
struct psAccess {
    static let templateID = "4629516633505792"
    static let username = "qRzZLVoAsRBEJcOUjWqgUyhxIZvLhooUnpdCGCYvtMLNaVNasonRhqjBAFZZksZz"
    
}

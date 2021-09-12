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
        UIColor(red: 73 / 255, green: 113 / 255, blue: 136 / 255, alpha: 1)
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

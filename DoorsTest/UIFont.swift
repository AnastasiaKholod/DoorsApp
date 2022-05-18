//
//  UIFont.swift
//  DoorsTest
//
//  Created by Macbook Pro 13 on 07.12.2021.
//

import Foundation
import UIKit

extension UIFont {
    enum Roboto {
        static func regular(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Regular", size: size)
        }

        static func light(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Light", size: size)
        }

        static func bold(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Bold", size: size)
        }

        static func medium(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Medium", size: size)
        }

        static func mediumItalic(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-MediumItalic", size: size)
        }
    }
}

enum Roboto: String, CustomFont {
    case regular = "Roboto-Regular"
    case light = "Roboto-Light"
    case bold = "Roboto-Bold"
    case medium = "Roboto-Medium"
    case mediumItalic = "Roboto-MediumItalic"

    func fontName() -> String {
        return self.rawValue
    }
}


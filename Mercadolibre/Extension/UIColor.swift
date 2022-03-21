//
//  UIColor.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 20-03-22.
//

import Foundation
import UIKit

extension UIColor {
    static func formHex(_ hex:UInt32, alpha: Double=1.0)->UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        return UIColor(red:red,green: green,blue: blue, alpha: alpha)
    }
}

//
//  Int.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 19-03-22.
//

import Foundation


extension Double {
    var formattedWithSeparator: String { Formatter.withDot.string(for: self) ?? "" }
    
    func toPrice() -> String {
        return "$ \(self.formattedWithSeparator)"
    }
    
    func toDiscount() -> String {
        return "\(self.formattedWithSeparator) % OFF"
    }
}

//
//  Formatter.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 20-03-22.
//

import Foundation

extension Formatter {
    static let withDot: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = "."
        return formatter
    }()
}

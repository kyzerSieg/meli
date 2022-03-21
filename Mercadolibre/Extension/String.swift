//
//  String.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 20-03-22.
//

import UIKit

extension String {
    func getLocalized() -> String {
       return NSLocalizedString(self, comment: "")
    }
}

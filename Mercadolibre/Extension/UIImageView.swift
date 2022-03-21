//
//  UIImageView.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 19-03-22.
//

import Foundation
import UIKit


extension UIImageView {
    func loadImage(urlStr: String) {
        if let url = URL(string: urlStr) {
            DispatchQueue.global().async { () in
                if let data = try? Data(contentsOf: url) {
                    if var image: UIImage? = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image!
                            image = nil
                        }
                    }
                }
            }
        }
    }
}

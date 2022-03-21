//
//  UIViewController.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 18-03-22.
//

import UIKit

extension UIViewController {
    func showAlert(_ title:String? = "title".getLocalized() , message: String? = "" ){
        let alert = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "roger".getLocalized(), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }    
}

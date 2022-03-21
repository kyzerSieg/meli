//
//  Loader.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 19-03-22.
//

import UIKit

class Loader: UIView {
    @IBOutlet weak var lblBackground: UILabel!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblLoading: UILabel!
    
    class func createViewLoader() -> Loader {
        let myClassNib = UINib(nibName: "Loader", bundle: nil)
        return myClassNib.instantiate(withOwner: nil, options: nil)[0] as! Loader
    }
}

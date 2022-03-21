//
//  SearchTableViewCell.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 19-03-22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblProductPrice: UILabel!
    @IBOutlet var lblProductCondition: UILabel!
    @IBOutlet var imgProduct: UIImageView!
        
    var item: Result? {
        didSet {
            guard let item = item else {
                return
            }
            imgProduct.loadImage(urlStr: item.thumbnail)
            lblProductName.text = "\(item.title)"
            lblProductPrice.text = "\(item.price.toPrice())"
            lblProductCondition.text = "\(item.condition!)"
        }
    }
    
    private var fila: Int = 0
    var row: Int = 0 {
        didSet{
            self.fila = row
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

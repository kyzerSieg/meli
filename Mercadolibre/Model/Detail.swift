//
//  Detail.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 19-03-22.
//

import Foundation
import RxDataSources

struct Detail: Codable {
    let id: String
    let seller_id: Int
    let title: String
    let category_id: String
    let official_store_id: String?
    let price: Double
    let base_price: Double
    let original_price: Double?
    let currency_id: String
    let initial_quantity: Int
    let available_quantity: Int
    let sold_quantity: Int
    let differential_pricing: Double?
    let pictures: [Pictures]
}

struct Pictures: Codable {
    let secure_url: String
}

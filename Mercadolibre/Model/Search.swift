//
//  Search.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 18-03-22.
//

import Foundation
import RxDataSources

struct Result: Codable {
    let id: String
    let site_id: String
    let title: String
    let thumbnail: String
    let price: Double
    var condition: String?
}

struct Paging: Codable {
    let total: Int
    let primary_results: Int
    let offset: Int
    let limit: Int
}

struct Search : Codable{
    let site_id: String
    let country_default_time_zone: String
    let query: String
    let paging: Paging
    let results:[Result]
}

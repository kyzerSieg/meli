//
//  RestApi.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 18-03-22.
//

import Alamofire


class RestApi {
    class var sharedInstance: RestApi {
        struct Static {
            static let instance = RestApi()
        }
        return Static.instance
    }
    
    
    func getSearch(textSearch: String, completion: @escaping (Search?) -> Void){
        let site_id="MLA"
        let url = "https://api.mercadolibre.com//sites/\(site_id)/search?q=\(textSearch)"
        Alamofire.request(
            URL(string: url)!,
            method: .get)
            .responseString { (response) -> Void in
                guard response.result.isSuccess else {
                    debugPrint("Error al buscar el filtro: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = try? JSONDecoder().decode(Search.self, from: response.data!) else {
                    debugPrint("Datos del servicio con problemas")
                    completion(nil)
                    return
                }
                completion(value)
        }
    }
    
    func getDetail(textSearch: String, completion: @escaping (Detail?) -> Void){
        let url = "https://api.mercadolibre.com/items/\(textSearch)"
        Alamofire.request(
            URL(string: url)!,
            method: .get)
            .responseString { (response) -> Void in
                guard response.result.isSuccess else {
                    debugPrint("Error al buscar el filtro: \(String(describing: response.result.error) )")
                    completion(nil)
                    return
                }
                
                guard let value = try? JSONDecoder().decode(Detail.self, from: response.data!) else {
                    debugPrint("Datos del servicio con problemas")
                    completion(nil)
                    return
                }
                completion(value)                
                
        }
    }
}

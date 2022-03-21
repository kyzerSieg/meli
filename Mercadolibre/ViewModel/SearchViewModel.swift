//
//  SearchViewModel.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 18-03-22.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import RxDataSources

protocol  SearchDelegate {    
    func onError(error: Error)
}

class SearchViewModel: NSObject {
    public var delegateVM: SearchDelegate? = nil
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let searchData: PublishSubject<Search> = PublishSubject()
    var itemSelected = [Result]()
    
    public func getFinder(textSearch: String){
        self.loading.onNext(true)
        RestApi.sharedInstance.getSearch(textSearch: textSearch,completion: { data in
            self.loading.onNext(false)
            if(data == nil){
                let error = Error(errorCode: 404, errorMessage: "not_found".getLocalized())
                self.delegateVM?.onError(error: error)
            }else{
                self.searchData.onNext(data!)
            }
        })
    }
}

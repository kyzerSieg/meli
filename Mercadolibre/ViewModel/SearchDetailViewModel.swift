//
//  SearchDetailViewModel.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 19-03-22.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import RxDataSources

protocol  SearchDetailDelegate {
    func onError(error: Error)
}

class SearchDetailViewModel: NSObject {
    public var delegateVM: SearchDetailDelegate? = nil
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let detailData: PublishSubject<Detail?> = PublishSubject()
    var itemSelected = [Result]()
    
    public func getDetail(item: Result){
        self.loading.onNext(true)
        RestApi.sharedInstance.getDetail(textSearch: item.id ,completion: { data in
            self.loading.onNext(false)
            if(data == nil){
                let error = Error(errorCode: 404, errorMessage: "not_found".getLocalized())
                self.delegateVM?.onError(error: error)
            }else{
                self.detailData.onNext(data!)
            }
        })
    }        
}

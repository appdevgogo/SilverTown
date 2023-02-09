//
//  SearchViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/28.
//

import Foundation
import RxSwift

class SearchViewModel {
    
    var items = PublishSubject<[Search]>()
    
    func fetchItem(data: [Search]){
        
        let itemList = data
        
        items.onNext(itemList)
       // items.onCompleted()
        
    }
}


struct SearchSubViewModel {
    

}

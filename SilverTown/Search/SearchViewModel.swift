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
    
    func fetchItem(){
        
        let itemList = [Search(addresses: ["서울특별시", "경기도", "인천광역시", "부산광역시", "울산광역시", "대전광역시", "광주광역시"], deposit: MinAndMax(min: 0, max: 100), monthlyFee: MinAndMax(min: 0, max: 100), utilityCost: MinAndMax(min: 0, max: 100))]
        
        items.onNext(itemList)
       // items.onCompleted()
        
    }
}


struct SearchSubViewModel {
    

}

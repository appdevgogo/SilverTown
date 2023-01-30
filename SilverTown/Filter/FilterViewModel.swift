//
//  FilterViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation
import RxSwift


class FilterViewModel {
    
    var items = PublishSubject<[Filter]>()
    
    func fetchItem(){
        
        let itemList = [Filter(addresses: ["서울특별시", "경기도", "인천광역시", "부산광역시", "대전광역시", "울산광역시", "광주광역시","세종특별자치시", "강원도", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도", "제주특별자치도"], deposit: MinAndMax(min: 0, max: 100), monthlyFee: MinAndMax(min: 0, max: 100), utilityCost: MinAndMax(min: 0, max: 100))]
        
        items.onNext(itemList)
        items.onCompleted()
        
    }
}


struct FilterSubViewModel {
    
    var items = PublishSubject<[String]>()
    
    func fetchItem(data: [String]){
        
        let itemList = data
        
        items.onNext(itemList)
        items.onCompleted()
        
    }
    

}

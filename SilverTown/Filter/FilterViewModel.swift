//
//  FilterViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation
import RxSwift
import CoreData


struct FilterViewModel {
    
    var items = PublishSubject<[Filter]>()
    var context: NSManagedObjectContext!
    
    func fetchItem(){
        
        let coreDataManager = CoreDataManager(context: context)
        
        let checkCoreData = coreDataManager.getDataFilter(entityName: "FilterCoreData")
        
        switch checkCoreData.count {
            
        case 0:
            
            let filterCoreData = Filter(addresses: ["서울특별시", "경기도", "인천광역시", "부산광역시", "대전광역시", "울산광역시", "광주광역시","세종특별자치시", "강원도", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도", "제주특별자치도"], depositMin: 0, depositMax: 100, monthlyFeeMin: 0, monthlyFeeMax: 100, utilityCostMin: 0, utilityCostMax: 100)
            
            coreDataManager.deleteAllData(entityName: "FilterCoreData")
            coreDataManager.saveDataFilter(filter: filterCoreData)
            
        default: break
            
        }
        
        let itemList = coreDataManager.getDataFilter(entityName: "FilterCoreData")
        
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

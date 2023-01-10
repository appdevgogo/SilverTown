//
//  HomeViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/10.
//

//import Foundation
import RxSwift


struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    
    func fetchItem(){
        let products = [
            Product(imageName: "imageName1", title: "title1"),
            Product(imageName: "imageName2", title: "title2"),
            Product(imageName: "imageName3", title: "title3"),
            Product(imageName: "imageName4", title: "title4"),
            Product(imageName: "imageName5", title: "title5"),
            Product(imageName: "imageName6", title: "title6"),
            Product(imageName: "imageName7", title: "title7"),
        ]
        
        items.onNext(products)
        items.onCompleted()
    }
    
}

struct FilterMainViewModel {
    var items = PublishSubject<[FilterMain]>()
    
    func fetchItem(){
        let filteritems = [
            FilterMain(name: "경기도"),
            FilterMain(name: "보증금 1~6억"),
            FilterMain(name: "월이용료 1~30만원"),
       
        ]
        
        items.onNext(filteritems)
        items.onCompleted()
    }
    
}

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
            FilterMain(name: "서울특별시 마포구"),
            FilterMain(name: "보증금 1~6억"),
            FilterMain(name: "월이용료 1~30만원"),
            FilterMain(name: "식비 1만4천원/1식"),
            FilterMain(name: "평생무료"),
            FilterMain(name: "또다른 옵션입니다."),
       
        ]
        
        items.onNext(filteritems)
        items.onCompleted()
    }
    
}

//
//  HomeViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/10.
//

//import Foundation
import RxSwift


struct TownMainViewModel {
    
    var items = PublishSubject<[TownMain]>()
    
    func fetchItem(){
        let itemList = [
            TownMain(title: "SK그레이스힐(Grace Hill)", description: "보증금 4억 / 월이용료 120만원\n세대관리비 18만원(21평형)", imageURL: "https://www.google.com/search?q=%EC%8B%A4%EB%B2%84%ED%83%80%EC%9A%B4&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjG4pzorMT8AhVQrlYBHUR7AuIQ_AUoAXoECAIQAw&biw=960&bih=870&dpr=1#imgrc=knMRMNZATpoamM"),
            TownMain(title: "더클래식500 실버타운", description: "보증금 8억 / 월이용료 167만원\n세대관리비 30만원(24평형)", imageURL: "https://www.google.com/search?q=%EC%8B%A4%EB%B2%84%ED%83%80%EC%9A%B4&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjG4pzorMT8AhVQrlYBHUR7AuIQ_AUoAXoECAIQAw&biw=960&bih=870&dpr=1#imgrc=SusQExuy0BqQUM"),
        ]
        
        items.onNext(itemList)
        items.onCompleted()
    }
    
}

struct FilterMainViewModel {
    
    var items = PublishSubject<[FilterMain]>()
    
    func fetchItem(){
        
        let itemList = [
            FilterMain(item: "서울특별시 마포구"),
            FilterMain(item: "보증금 1~6억"),
            FilterMain(item: "월이용료 1~30만원"),
            FilterMain(item: "식비 1만4천원/1식"),
            FilterMain(item: "건강검진 평생무료"),
            FilterMain(item: "실비보험 적용"),
        ]
        
        items.onNext(itemList)
        items.onCompleted()
    }
    
}

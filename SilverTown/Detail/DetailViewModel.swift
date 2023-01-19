//
//  DetailViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/15.
//

import RxSwift

struct DetailSilverTownViewModel {
    
    var items = PublishSubject<[DetailSilverTown]>()
    
    func fetchItem(){
        
        let itemList = [DetailSilverTown(title: "더클래식500 실버타운", address: "서울특별시 광진구 능동로 90", subTitleFirst: "공급면적", subTitleSecond: "금액", subContentFirst: "24평형\n(138.76m2)", subContentSecond: "  보증금 8억\n  월이용료 167만원\n  세대관리비 30만원", subOther: "  식대(별도) : 1만4천원/1식")]
        
        items.onNext(itemList)
        items.onCompleted()
    }
    
}

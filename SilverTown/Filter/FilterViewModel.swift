//
//  FilterViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation
import RxSwift
import RxCocoa


class FilterViewModel {
    
    var items = PublishSubject<[TableData]>()
    
    func fetchItem(){
        
        print("------------>> FilterViewModel.fetchItem() 실행됨??")
        
        let itemList = [
            TableData(
                title: "더클래식500 실버타운",
                address: "서울특별시 광진구 능동로 90",
                subTitleFirst: "공급면적",
                subTitleSecond: "금액",
                subContentFirst: "24평형\n(138.76m2)",
                subContentSecond: "  보증금 8억\n  월이용료 167만원\n  세대관리비 30만원",
                subOther: "  식대(별도) : 1만4천원 / 1식",
                imageURLs: [CollectionData(imageURL: "https://dimg.donga.com/wps/NEWS/IMAGE/2022/04/21/112983704.5.jpg"),
                            CollectionData(imageURL: "https://img.youtube.com/vi/SFdScbQPQmM/0.jpg"),
                            CollectionData(imageURL: "https://img.youtube.com/vi/7fNhz1dbMQQ/0.jpg")],
                youtubeURLs: ["https://img.youtube.com/vi/SFdScbQPQmM/0.jpg", "https://img.youtube.com/vi/7fNhz1dbMQQ/0.jpg"])]
        
        items.onNext(itemList)
        items.onCompleted()
    }
    
}


struct FilterSubViewModel {
    
    var items = PublishSubject<[CollectionData]>()
    
    func fetchItem(data : [CollectionData] ){
        
        let itemList = data
        
        items.onNext(itemList)
        items.onCompleted()
    }
    
}

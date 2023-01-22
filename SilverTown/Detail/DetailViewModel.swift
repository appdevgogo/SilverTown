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
        
        let itemList = [DetailSilverTown(title: "더클래식500 실버타운", address: "서울특별시 광진구 능동로 90", subTitleFirst: "공급면적", subTitleSecond: "금액", subContentFirst: "24평형\n(138.76m2)", subContentSecond: "  보증금 8억\n  월이용료 167만원\n  세대관리비 30만원", subOther: "  식대(별도) : 1만4천원 / 1식", imageURLs: ["https://dimg.donga.com/wps/NEWS/IMAGE/2022/04/21/112983704.5.jpg",  "https://news.imaeil.com/photos/2019/05/28/2019052816581390757_l.jpg", "https://cdn.dailyimpact.co.kr/news/photo/202104/68343_42316_2142.jpg"], youtubeURLs: ["https://img.youtube.com/vi/SFdScbQPQmM/0.jpg", "https://img.youtube.com/vi/7fNhz1dbMQQ/0.jpg"])]
        
        items.onNext(itemList)
        items.onCompleted()
    }
    
}


struct DetailSilverTownSubImgViewModel {
    
    var items = PublishSubject<[DetailSilverTownImgSub]>()
    
    func fetchItem(){
        
        let itemList = [
            DetailSilverTownImgSub(imageURL: ""),
            DetailSilverTownImgSub(imageURL: ""),
            DetailSilverTownImgSub(imageURL: "")
        ]
        
        items.onNext(itemList)
        items.onCompleted()
    }
    
}

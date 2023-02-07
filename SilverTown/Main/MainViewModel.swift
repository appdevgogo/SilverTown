//
//  HomeViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/10.
//

//import Foundation
import RxSwift

struct MainFilterViewModel {
    
    let items = PublishSubject<[MainFilter]>()
    
    func fetchItem(data: [MainFilter]){
        
        let itemList = data
        /*
        let itemList = [
            MainFilter(item: "서울특별시 마포구"),
            MainFilter(item: "보증금 1~6억"),
            MainFilter(item: "월이용료 1~30만원"),
            MainFilter(item: "식비 1만4천원/1식"),
            MainFilter(item: "건강검진 평생무료"),
            MainFilter(item: "실비보험 적용"),
        ]*/
        
        items.onNext(itemList)
      //  items.onCompleted()
    }
    
}

struct MainSilverTownViewModel {
    
    let items = PublishSubject<[MainSilverTown]>()
    
    func fetchItem(){
        
        let itemList = [
            MainSilverTown(
                title: "SK그레이스힐(Grace Hill)",
                description: "보증금 4억 / 월이용료 120만원\n세대관리비 18만원(21평형)",
                imageURLs: [MainSilverTownSub(imageURL: "https://dimg.donga.com/wps/NEWS/IMAGE/2022/04/21/112983704.5.jpg"),
                            MainSilverTownSub(imageURL: "https://news.imaeil.com/photos/2019/05/28/2019052816581390757_l.jpg"),
                            MainSilverTownSub(imageURL: "https://cdn.dailyimpact.co.kr/news/photo/202104/68343_42316_2142.jpg")]),
            
            MainSilverTown(
                title: "더클래식500 실버타운",
                description: "보증금 8억 / 월이용료 167만원\n세대관리비 30만원(24평형)",
                imageURLs: [MainSilverTownSub(imageURL:"https://dimg.donga.com/wps/NEWS/IMAGE/2020/06/03/101324166.5.jpg"),
                            MainSilverTownSub(imageURL:"https://www.thedailypost.kr/news/photo/202002/73007_64794_1959.jpg"),
                            MainSilverTownSub(imageURL:"https://dimg.donga.com/wps/NEWS/IMAGE/2021/04/08/106312456.2.jpg")])
            ]
        
        items.onNext(itemList)
        items.onCompleted()

    }
    
}

struct MainSilverTownSubViewModel {
    
    let items = PublishSubject<[MainSilverTownSub]>()
    
    func fetchItem(data: [MainSilverTownSub]){
        
        let itemList = data
        
        items.onNext(itemList)
        items.onCompleted()
    }
    
}

/*
 "https://dimg.donga.com/wps/NEWS/IMAGE/2022/04/21/112983704.5.jpg",
 "https://news.imaeil.com/photos/2019/05/28/2019052816581390757_l.jpg",
 "https://cdn.dailyimpact.co.kr/news/photo/202104/68343_42316_2142.jpg"


 "https://dimg.donga.com/wps/NEWS/IMAGE/2020/06/03/101324166.5.jpg",
 "https://www.thedailypost.kr/news/photo/202002/73007_64794_1959.jpg",
 "https://dimg.donga.com/wps/NEWS/IMAGE/2021/04/08/106312456.2.jpg"

 "https://newsimg.sedaily.com/2017/09/03/1OKVUPOCKP_1.jpg",
 "https://img.etoday.co.kr/pto_db/2014/02/600/20140203051815_403252_836_554.JPG",
 "https://wimg.mk.co.kr/meet/neds/2015/10/image_readtop_2015_1019968_14458278062191475.jpg"
 */


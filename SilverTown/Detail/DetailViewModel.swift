//
//  DetailViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/15.
//

import RxSwift
import CoreData

struct DetailSilverTownViewModel {
    
    var items = PublishSubject<[DetailSilverTown]>()
    
    func fetchItem(){
        
        let itemList = [
            DetailSilverTown(
                id: "st00001",
                title: "더클래식500 실버타운",
                address: "서울특별시 광진구 능동로 90",
                subTitleFirst: "공급면적",
                subTitleSecond: "금액",
                subContentFirst: "24평형\n(138.76m2)",
                subContentSecond: "  보증금 8억\n  월이용료 167만원\n  세대관리비 30만원",
                subOther: "  식대(별도) : 1만4천원 / 1식",
                imageURLs: [
                    DetailSilverTownSubImage(imageURL: "https://dimg.donga.com/wps/NEWS/IMAGE/2022/04/21/112983704.5.jpg"),
                    DetailSilverTownSubImage(imageURL: "https://news.imaeil.com/photos/2019/05/28/2019052816581390757_l.jpg"),
                    DetailSilverTownSubImage(imageURL: "https://cdn.dailyimpact.co.kr/news/photo/202104/68343_42316_2142.jpg")],
                imageURLsFirst: [
                    DetailSilverTownSubImage(imageURL: "https://dimg.donga.com/wps/NEWS/IMAGE/2022/04/21/112983704.5.jpg"),
                    DetailSilverTownSubImage(imageURL: "https://news.imaeil.com/photos/2019/05/28/2019052816581390757_l.jpg"),
                    DetailSilverTownSubImage(imageURL: "https://cdn.dailyimpact.co.kr/news/photo/202104/68343_42316_2142.jpg")],
                imageURLsSecond: [
                    DetailSilverTownSubImage(imageURL: "https://dimg.donga.com/wps/NEWS/IMAGE/2020/06/03/101324166.5.jpg"),
                    DetailSilverTownSubImage(imageURL: "https://www.thedailypost.kr/news/photo/202002/73007_64794_1959.jpg"),
                    DetailSilverTownSubImage(imageURL: "https://dimg.donga.com/wps/NEWS/IMAGE/2021/04/08/106312456.2.jpg")],
                imageURLsThird: [
                    DetailSilverTownSubImage(imageURL: "https://newsimg.sedaily.com/2017/09/03/1OKVUPOCKP_1.jpg"),
                    DetailSilverTownSubImage(imageURL: "https://img.etoday.co.kr/pto_db/2014/02/600/20140203051815_403252_836_554.JPG"),
                    DetailSilverTownSubImage(imageURL: "https://wimg.mk.co.kr/meet/neds/2015/10/image_readtop_2015_1019968_14458278062191475.jpg")],
                youtubeIDs: ["SFdScbQPQmM", "7fNhz1dbMQQ"])]
                                          
        
        items.onNext(itemList)
        items.onCompleted()
        
        saveDetailSilverDown(id: itemList[0].id, title: itemList[0].title, address: itemList[0].address)
        
    }
    
    func saveDetailSilverDown(id: String, title: String, address: String) {
        
        let coreDataManager = CoreDataManager()
        let toSaveData =
            DetailSilverTownToSave(id: id, title: title, address: address)

        coreDataManager.saveDataDetailSilverTown(detailSilverTown: toSaveData)
        
    }
    
}


struct DetailSilverTownSubImageViewModel {
    
    var items = PublishSubject<[DetailSilverTownSubImage]>()
    
    func fetchItem(data: [DetailSilverTownSubImage]){
        
        let itemList = data
        
        items.onNext(itemList)
        //items.onCompleted()
    }
    
}

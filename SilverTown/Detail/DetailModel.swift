//
//  DetailModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/15.
//

import Foundation
import RxDataSources


struct DetailSilverTown {
    
    let title: String
    let address: String
    let subTitleFirst: String
    let subTitleSecond: String
    let subContentFirst: String
    let subContentSecond: String
    let subOther: String
    let imageURLs: [String]
    let youtubeURLs: [String]
    
}


struct DetailSilverTownImgSub {
    
    let imageURL: String
}

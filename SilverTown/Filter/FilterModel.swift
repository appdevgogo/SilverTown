//
//  FilterModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation


struct TableData {
    
    let title: String
    let address: String
    let subTitleFirst: String
    let subTitleSecond: String
    let subContentFirst: String
    let subContentSecond: String
    let subOther: String
    let imageURLs: [CollectionData]
    let youtubeURLs: [String]
    
}


struct CollectionData {
    
    let imageURL: String
}

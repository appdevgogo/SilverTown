//
//  FilterModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation
import RxDataSources


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

struct MySection {
    var header: String
    var items: [Item]
}

// section Model
extension MySection: AnimatableSectionModelType {
    typealias Item = Int
    
    init(original: MySection, items: [Int]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
}


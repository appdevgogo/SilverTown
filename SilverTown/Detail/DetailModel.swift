//
//  DetailModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/15.
//

import Foundation


struct DetailSilverTown {
    
    let id: String
    let title: String
    let address: String
    let subTitleFirst: String
    let subTitleSecond: String
    let subContentFirst: String
    let subContentSecond: String
    let subOther: String
    let imageURLs: [DetailSilverTownSubImage]
    let imageURLsFirst: [DetailSilverTownSubImage]
    let imageURLsSecond: [DetailSilverTownSubImage]
    let imageURLsThird: [DetailSilverTownSubImage]
    let youtubeIDs: [String]
    
}

struct DetailSilverTownSubImage {
    
    let imageURL: String
}

struct DetailSilverTownToSave {
    
    let id: String
    let title: String
    let address: String
    
}

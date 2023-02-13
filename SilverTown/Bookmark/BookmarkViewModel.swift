//
//  BookmarkViewModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/02/11.
//

import Foundation
import RxSwift


class BookmarkViewModel {
    
    var items = PublishSubject<[Bookmark]>()
    
    func fetchItem(data: [Bookmark]){
        
        let itemList = data
        
        items.onNext(itemList)
       // items.onCompleted()
        
    }
}




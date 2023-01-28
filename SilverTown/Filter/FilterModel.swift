//
//  FilterModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation


struct Filter {
    
    let addresses: [String]
    let deposit: MinAndMax
    let monthlyFee: MinAndMax
    let utilityCost: MinAndMax
    
}


struct MinAndMax {
    
    let min: Int
    let max: Int
}



/*
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
}*/


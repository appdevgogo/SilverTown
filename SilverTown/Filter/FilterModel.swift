//
//  FilterModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation


struct Filter {
    
    let addresses: [String]
    var depositMin: Int
    var depositMax: Int
    var monthlyFeeMin : Int
    var monthlyFeeMax : Int
    var utilityCostMin : Int
    var utilityCostMax : Int
    
}


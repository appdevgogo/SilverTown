//
//  FilterModel.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation


struct Filter {
    
    let addresses: [String]
    let depositMin: Int
    let depositMax: Int
    let monthlyFeeMin : Int
    let monthlyFeeMax : Int
    let utilityCostMin : Int
    let utilityCostMax : Int
    
}


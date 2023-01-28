//
//  FilterCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleAddressLabel: UILabel!
    @IBOutlet weak var titleDepositLabel: UILabel!
    @IBOutlet weak var titleMonthlyFeeLabel: UILabel!
    @IBOutlet weak var titleUtilityCostLabel: UILabel!
    
}


class FilterSubCollectionViewCell : UICollectionViewCell {
    
    var imageURL: String = ""
    
}

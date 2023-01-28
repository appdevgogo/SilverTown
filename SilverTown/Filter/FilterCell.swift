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
    
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var depositTitleLabel: UILabel!
    @IBOutlet weak var depositMinLabel: PaddingLabel!
    @IBOutlet weak var depositMaxLabel: PaddingLabel!
    @IBOutlet weak var monthlyFeeTitleLabel: UILabel!
    @IBOutlet weak var monthlyMinLabel: PaddingLabel!
    @IBOutlet weak var monthlyMaxLabel: PaddingLabel!
    @IBOutlet weak var utilityCostTitleLabel: UILabel!
    @IBOutlet weak var utilityCostMinLabel: PaddingLabel!
    @IBOutlet weak var utilityCostMaxLabel: PaddingLabel!
    
    
    override func awakeFromNib() {
        
        minMaxBorderRound()
        
    }
    
    
    func minMaxBorderRound(){
        
        depositMinLabel.minMaxLabelInitLayout()
        //depositMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        depositMaxLabel.minMaxLabelInitLayout()
        //depositMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        monthlyMinLabel.minMaxLabelInitLayout()
        //monthlyMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        monthlyMaxLabel.minMaxLabelInitLayout()
        //monthlyMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        utilityCostMinLabel.minMaxLabelInitLayout()
        //utilityCostMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        utilityCostMaxLabel.minMaxLabelInitLayout()
        //utilityCostMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
    }
}


class FilterSubCollectionViewCell : UICollectionViewCell {
    
    var imageURL: String = ""
    
}

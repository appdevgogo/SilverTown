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
import MultiSlider


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
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var depositSlider: UISlider!
    
    
    
    
    override func awakeFromNib() {
        
        minMaxBorderRound()
        test()
        
    }
    
    
    func minMaxBorderRound(){
        
        depositMinLabel.minMaxLabelInitLayout()
        depositMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        
        depositMaxLabel.minMaxLabelInitLayout()
        depositMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        monthlyMinLabel.minMaxLabelInitLayout()
        monthlyMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        monthlyMaxLabel.minMaxLabelInitLayout()
        monthlyMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        utilityCostMinLabel.minMaxLabelInitLayout()
        utilityCostMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        utilityCostMaxLabel.minMaxLabelInitLayout()
        utilityCostMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
    }
    
    func test(){
        
        depositSlider.tintColor = .basicRed
        depositSlider.thumbTintColor = .basicRed
        
        depositSlider.minimumValue = 1    // default is 0.0
        depositSlider.maximumValue = 5
        //depositSlider.snapStepSize = 0.5

        let horizontalMultiSlider = MultiSlider()
        horizontalMultiSlider.orientation = .horizontal
        horizontalMultiSlider.minimumValue = 10 / 4
        horizontalMultiSlider.maximumValue = 10 / 3
        horizontalMultiSlider.outerTrackColor = .gray
        horizontalMultiSlider.value = [2.718, 3.14]
        horizontalMultiSlider.valueLabelPosition = .top
        horizontalMultiSlider.tintColor = .purple
        horizontalMultiSlider.trackWidth = 32
        horizontalMultiSlider.showsThumbImageShadow = false
        horizontalMultiSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        testView.addConstrainedSubview(horizontalMultiSlider, constrain: .leftMargin, .rightMargin, .bottomMargin)
        testView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        
    }
    
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }


}


class FilterSubCollectionViewCell : UICollectionViewCell {
    
    var imageURL: String = ""
    
}

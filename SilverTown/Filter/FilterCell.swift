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
    @IBOutlet weak var monthlyFeeMinLabel: PaddingLabel!
    @IBOutlet weak var monthlyFeeMaxLabel: PaddingLabel!
    @IBOutlet weak var utilityCostTitleLabel: UILabel!
    @IBOutlet weak var utilityCostMinLabel: PaddingLabel!
    @IBOutlet weak var utilityCostMaxLabel: PaddingLabel!
    
    @IBOutlet weak var depositSliderView: UIView!
    @IBOutlet weak var monthlyFeeSliderView: UIView!
    @IBOutlet weak var utilityCostSliderView: UIView!
    
    @IBOutlet weak var filterSubCollectionView: UICollectionView!
    
    var filterSubViewModel = FilterSubViewModel()
    var disposeBag = DisposeBag()
    
    
    override func awakeFromNib() {
        
        self.selectionStyle = .none
        minMaxBorderRound()
        setSliders()
        
    }
    
    
    func minMaxBorderRound(){
        
        depositMinLabel.minMaxLabelInitLayout()
        depositMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        depositMaxLabel.minMaxLabelInitLayout()
        depositMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        monthlyFeeMinLabel.minMaxLabelInitLayout()
        monthlyFeeMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        monthlyFeeMaxLabel.minMaxLabelInitLayout()
        monthlyFeeMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        utilityCostMinLabel.minMaxLabelInitLayout()
        utilityCostMinLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        utilityCostMaxLabel.minMaxLabelInitLayout()
        utilityCostMaxLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
    }
    
    func setSliders(){
        
        let depositSlider = MultiSlider()
        depositSlider.setBasicRedMultiSlider(min: 0, max: 20)
        depositSlider.value = [0, 20]
        depositSlider.snapStepSize = 1.0
        depositSlider.addTarget(self, action: #selector(depositSliderChange), for: .valueChanged)
        depositSliderView.addConstrainedSubview(depositSlider, constrain: .leftMargin, .rightMargin, .bottomMargin)
        
        let monthlyFeeSlider = MultiSlider()
        monthlyFeeSlider.setBasicRedMultiSlider(min: 0, max: 100)
        monthlyFeeSlider.value = [0, 100]
        monthlyFeeSlider.snapStepSize = 10.0
        monthlyFeeSlider.addTarget(self, action: #selector(monthlyFeeSliderChange), for: .valueChanged)
        monthlyFeeSliderView.addConstrainedSubview(monthlyFeeSlider, constrain: .leftMargin, .rightMargin, .bottomMargin)
        
        let utilityCostSlider = MultiSlider()
        utilityCostSlider.setBasicRedMultiSlider(min: 0, max: 50)
        utilityCostSlider.value = [0, 50]
        utilityCostSlider.snapStepSize = 5.0
        utilityCostSlider.addTarget(self, action: #selector(utilityCostSliderChange), for: .valueChanged)
        utilityCostSliderView.addConstrainedSubview(utilityCostSlider, constrain: .leftMargin, .rightMargin, .bottomMargin)
    }
    
    
    @objc func depositSliderChange(_ slider: MultiSlider) {
        depositMinLabel.text = "\(Int(slider.value[0]))억"
        depositMaxLabel.text = "\(Int(slider.value[1]))억"
    }
    
    @objc func monthlyFeeSliderChange(_ slider: MultiSlider) {
        monthlyFeeMinLabel.text = "\(Int(slider.value[0]))만"
        monthlyFeeMaxLabel.text = "\(Int(slider.value[1]))만"
    }
    
    @objc func utilityCostSliderChange(_ slider: MultiSlider) {
        utilityCostMinLabel.text = "\(Int(slider.value[0]))만"
        utilityCostMaxLabel.text = "\(Int(slider.value[1]))만"
    }


}


class FilterSubCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var addressLabel: PaddingLabel!
}

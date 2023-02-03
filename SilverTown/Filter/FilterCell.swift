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
    @IBOutlet weak var addressContentButton: UIButton!
    @IBOutlet weak var addressContentHeight: NSLayoutConstraint!
    
    var depositSlider = MultiSlider()
    var monthlyFeeSlider = MultiSlider()
    var utilityCostSlider = MultiSlider()

    var filterSubViewModel = FilterSubViewModel()
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        
        initSetting()
      //  addressContentButtonAction()
        minMaxBorderRound()
        setSliders()
        
    }
    
    
    func initSetting(){
        
        self.selectionStyle = .none
        
    }
    /*
    func addressContentButtonAction(){
        
        addressContentButton.rx.tap.bind{

            self.addressContentHeight.constant = self.filterSubCollectionView.contentSize.height + 140
            self.filterSubCollectionView.layoutIfNeeded()
            
        }.disposed(by: disposeBag)
        
    }*/
    
    
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
        
        depositSlider.setBasicRedMultiSlider(min: 0, max: 20)
        depositSlider.snapStepSize = 1.0
        depositSlider.addTarget(self, action: #selector(depositSliderChange), for: .valueChanged)
        depositSliderView.addConstrainedSubview(depositSlider, constrain: .leftMargin, .rightMargin, .bottomMargin)
        
        monthlyFeeSlider.setBasicRedMultiSlider(min: 0, max: 100)
        monthlyFeeSlider.snapStepSize = 10.0
        monthlyFeeSlider.addTarget(self, action: #selector(monthlyFeeSliderChange), for: .valueChanged)
        monthlyFeeSliderView.addConstrainedSubview(monthlyFeeSlider, constrain: .leftMargin, .rightMargin, .bottomMargin)
        
        utilityCostSlider.setBasicRedMultiSlider(min: 0, max: 50)
        utilityCostSlider.snapStepSize = 5.0
        utilityCostSlider.addTarget(self, action: #selector(utilityCostSliderChange), for: .valueChanged)
        utilityCostSliderView.addConstrainedSubview(utilityCostSlider, constrain: .leftMargin, .rightMargin, .bottomMargin)
    }
    
    
    @objc func depositSliderChange(_ slider: MultiSlider) {
        depositMinLabel.text = "\(Int(slider.value[0]))억원"
        depositMaxLabel.text = "\(Int(slider.value[1]))억원"
    }
    
    @objc func monthlyFeeSliderChange(_ slider: MultiSlider) {
        monthlyFeeMinLabel.text = "\(Int(slider.value[0]))만원"
        monthlyFeeMaxLabel.text = "\(Int(slider.value[1]))만원"
    }
    
    @objc func utilityCostSliderChange(_ slider: MultiSlider) {
        utilityCostMinLabel.text = "\(Int(slider.value[0]))만원"
        utilityCostMaxLabel.text = "\(Int(slider.value[1]))만원"
    }


}


class FilterSubCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var addressLabel: PaddingLabel!
}

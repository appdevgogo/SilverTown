//
//  DetailCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/19.
//

import UIKit
import RxSwift
import RxCocoa


class DetailSilverTownTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var subTitleFirstLabel: UILabel!
    @IBOutlet weak var subTitleSecondLabel: UILabel!
    @IBOutlet weak var subContentFirstLabel: UILabel!
    @IBOutlet weak var subContentSecondLabel: PaddingLabel!
    @IBOutlet weak var subOtherLabel: UILabel!
    
    @IBOutlet weak var imgTitleFirstButton: UIButton!
    @IBOutlet weak var imgTitleSecondButton: UIButton!
    @IBOutlet weak var imgTitleThirdButton: UIButton!
    
    override func awakeFromNib() {
        
        addSubBorders()
        imgTitleBorderRound()
        
    }
    
    func addSubBorders(){
        
        subTitleFirstLabel.layer.addBorder(edge: UIRectEdge.top, color: .systemGray4, thickness: 1.0)
        subTitleFirstLabel.layer.addBorder(edge: UIRectEdge.bottom, color: .systemGray4, thickness: 1.0)
        subTitleFirstLabel.layer.addBorder(edge: UIRectEdge.left, color: .systemGray4, thickness: 1.0)
        subTitleFirstLabel.layer.addBorder(edge: UIRectEdge.right, color: .systemGray4, thickness: 1.0)
        
        subTitleSecondLabel.layer.addBorder(edge: UIRectEdge.top, color: .systemGray4, thickness: 1.0)
        subTitleSecondLabel.layer.addBorder(edge: UIRectEdge.bottom, color: .systemGray4, thickness: 1.0)
        subTitleSecondLabel.layer.addBorder(edge: UIRectEdge.right, color: .systemGray4, thickness: 1.0)
        
        subContentFirstLabel.layer.addBorder(edge: UIRectEdge.bottom, color: .systemGray4, thickness: 1.0)
        subContentFirstLabel.layer.addBorder(edge: UIRectEdge.left, color: .systemGray4, thickness: 1.0)
        subContentFirstLabel.layer.addBorder(edge: UIRectEdge.right, color: .systemGray4, thickness: 1.0)
        
        subContentSecondLabel.layer.addBorder(edge: UIRectEdge.bottom, color: .systemGray4, thickness: 1.0)
        subContentSecondLabel.layer.addBorder(edge: UIRectEdge.right, color: .systemGray4, thickness: 1.0)
        
        subOtherLabel.layer.addBorder(edge: UIRectEdge.bottom, color: .systemGray4, thickness: 1.0)
        subOtherLabel.layer.addBorder(edge: UIRectEdge.left, color: .systemGray4, thickness: 1.0)
        subOtherLabel.layer.addBorder(edge: UIRectEdge.right, color: .systemGray4, thickness: 1.0)
        
    }
    
    func imgTitleBorderRound(){
        
        imgTitleFirstButton.layer.borderWidth = 2
        imgTitleFirstButton.layer.borderColor = UIColor.basicPurple.cgColor
        imgTitleFirstButton.layer.cornerRadius = 10
        imgTitleFirstButton.clipsToBounds = true
        imgTitleFirstButton.titleLabel?.textColor = .basicPurple
        
        imgTitleSecondButton.layer.borderWidth = 1
        imgTitleSecondButton.layer.borderColor = UIColor.systemGray6.cgColor
        imgTitleSecondButton.layer.cornerRadius = 10
        imgTitleSecondButton.clipsToBounds = true
        imgTitleSecondButton.titleLabel?.textColor = .systemGray6
        
        
    }
    
}

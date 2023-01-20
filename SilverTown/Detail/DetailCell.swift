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
    @IBOutlet weak var subContentSecondLabel: UILabel!
    @IBOutlet weak var subOtherLabel: UILabel!
    
    @IBOutlet weak var imgTitleFirstButton: UIButton!
    @IBOutlet weak var imgTitleSecondButton: UIButton!
    @IBOutlet weak var imgTitleThirdButton: UIButton!
    
    @IBOutlet weak var detailSilverTownSubCV: UICollectionView!
    private var detailSilverTownSubViewModel = DetailSilverTownSubViewModel()
    private var detailSilverTownSubBag = DisposeBag()
    var imgURLs: [String] = []
    
    @IBOutlet weak var detailImgCount: UILabel!
    
    
    override func awakeFromNib() {
        
        addSubBorders()
        imgTitleBorderRound()
        bindDetailSilverTownSubCV()
        
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
        imgTitleFirstButton.layer.cornerRadius = 15
        imgTitleFirstButton.clipsToBounds = true
        imgTitleFirstButton.titleLabel?.textColor = .basicPurple
        
        imgTitleSecondButton.layer.borderWidth = 1
        imgTitleSecondButton.layer.borderColor = UIColor.systemGray2.cgColor
        imgTitleSecondButton.layer.cornerRadius = 15
        imgTitleSecondButton.clipsToBounds = true
        imgTitleSecondButton.titleLabel?.textColor = .systemGray2
        
        imgTitleThirdButton.layer.borderWidth = 1
        imgTitleThirdButton.layer.borderColor = UIColor.systemGray2.cgColor
        imgTitleThirdButton.layer.cornerRadius = 15
        imgTitleThirdButton.clipsToBounds = true
        imgTitleThirdButton.titleLabel?.textColor = .systemGray2
        
    }
    
    func bindDetailSilverTownSubCV(){
        
        detailSilverTownSubViewModel.items.bind(
            to: detailSilverTownSubCV.rx.items(
                cellIdentifier: "cell",
                cellType: DetailSilverTownSubCVC.self)
        ){ index, model, cell in
            
            cell.itemImage.layer.cornerRadius = 15
            
            switch self.imgURLs[index] {
            case "none", "":
                print("No image available")
            default :
                guard let url = URL(string: self.imgURLs[index]) else { return }
                cell.itemImage.kf.setImage(with: url)
             }
                
        }.disposed(by: detailSilverTownSubBag)
        
        detailSilverTownSubCV
            .rx.setDelegate(self)
            .disposed(by: detailSilverTownSubBag)
        
        detailSilverTownSubCV.rx.modelSelected(MainSilverTownSub.self).bind { element in
        }.disposed(by: detailSilverTownSubBag)
        
        detailSilverTownSubViewModel.fetchItem()
        
    }
    
}

extension DetailSilverTownTVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2)
                print("page = \(page)")
        
        self.detailImgCount.text = "\(page) / \(self.imgURLs.count)"
            // Do whatever with currentPage.
    }
    
}


class DetailSilverTownSubCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
}

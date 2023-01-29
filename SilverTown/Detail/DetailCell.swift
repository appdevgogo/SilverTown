//
//  DetailCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/19.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class DetailSilverTownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var subTitleFirstLabel: UILabel!
    @IBOutlet weak var subTitleSecondLabel: UILabel!
    @IBOutlet weak var subContentFirstLabel: UILabel!
    @IBOutlet weak var subContentSecondLabel: UILabel!
    @IBOutlet weak var subOtherLabel: UILabel!
    @IBOutlet weak var detailImageCount: UILabel!
    
    @IBOutlet weak var imageTitleFirstButton: UIButton!
    @IBOutlet weak var imageTitleSecondButton: UIButton!
    @IBOutlet weak var imageTitleThirdButton: UIButton!
    
    @IBOutlet weak var youtubeFirstImageView: UIImageView!
    @IBOutlet weak var youtubeSecondImageView: UIImageView!
    
    @IBOutlet weak var detailSilverTownSubImageCollectionView: UICollectionView!
    
    var detailSilverTownSubImageViewModel = DetailSilverTownSubImageViewModel()
    var disposeBag = DisposeBag()
    
    var imageCount: Int = 0
    var widthBase: CGFloat = 0.0
    
    override func awakeFromNib() {
        
        adjustLayout()
        addSubBorders()
        imageTitleBorderRound()
        imageTitleButtonsAction()
        detailSilverTownSubImageCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    func adjustLayout(){
               
        titleLabel.frame.size.width = UIScreen.main.bounds.width - 40
        addressLabel.frame.size.width = titleLabel.frame.width
        subTitleSecondLabel.frame.size.width = titleLabel.frame.width - subTitleFirstLabel.frame.width
        subContentSecondLabel.frame.size.width = subTitleSecondLabel.frame.size.width
        subOtherLabel.frame.size.width = titleLabel.frame.width

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
    
    func imageTitleBorderRound(){
        
        imageTitleFirstButton.detailImageTitleButtonOn()
        imageTitleSecondButton.detailImageTitleButtonOff()
        imageTitleThirdButton.detailImageTitleButtonOff()
        
    }
    
    func imageTitleButtonsAction(){
        
        imageTitleFirstButton.rx.tap.bind{
            
            self.imageTitleFirstButton.detailImageTitleButtonOn()
            self.imageTitleSecondButton.detailImageTitleButtonOff()
            self.imageTitleThirdButton.detailImageTitleButtonOff()
            self.detailSilverTownSubImageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            
        }.disposed(by: disposeBag)
        
        imageTitleSecondButton.rx.tap.bind{
            
            self.imageTitleFirstButton.detailImageTitleButtonOff()
            self.imageTitleSecondButton.detailImageTitleButtonOn()
            self.imageTitleThirdButton.detailImageTitleButtonOff()
            self.detailSilverTownSubImageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            
        }.disposed(by: disposeBag)
        
        imageTitleThirdButton.rx.tap.bind{
            
            self.imageTitleFirstButton.detailImageTitleButtonOff()
            self.imageTitleSecondButton.detailImageTitleButtonOff()
            self.imageTitleThirdButton.detailImageTitleButtonOn()
            
            self.detailSilverTownSubImageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            
        }.disposed(by: disposeBag)
        
    }
    
}

extension DetailSilverTownTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2)
        self.detailImageCount.text = "\(page) / \(self.imageCount)"
    }
    
}


class DetailSilverTownSubImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
}

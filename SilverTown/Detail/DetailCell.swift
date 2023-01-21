//
//  DetailCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


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
        buttonsAction()
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
        
        detailSilverTownSubCV.rx.setDelegate(self).disposed(by: detailSilverTownSubBag)
        
        detailSilverTownSubViewModel.items.bind(
            to: detailSilverTownSubCV.rx.items(
                cellIdentifier: "cell",
                cellType: DetailSilverTownSubCVC.self)

        ){ index, model, cell in
            
            print(">>>>>>>>>>>>>>>>>>>")
            print(index)
    
            cell.itemImage.layer.cornerRadius = 15
            
            switch self.imgURLs[index] {
            case "none", "":
                print("No image available")
            default :
                guard let url = URL(string: self.imgURLs[index]) else { return }
                cell.itemImage.kf.setImage(with: url)
             }
                
        }.disposed(by: detailSilverTownSubBag)
        
        detailSilverTownSubCV.rx.modelSelected(MainSilverTownSub.self).bind { element in
        }.disposed(by: detailSilverTownSubBag)
        
        detailSilverTownSubViewModel.fetchItem()
        
    }
    
    func buttonsAction(){
        
        imgTitleFirstButton.rx.tap.bind{
            
            self.imgTitleFirstButton.tintColor = .basicPurple
            self.imgTitleFirstButton.layer.borderWidth = 2
            self.imgTitleFirstButton.layer.borderColor = UIColor.basicPurple.cgColor
            
            self.imgTitleSecondButton.tintColor = .systemGray2
            self.imgTitleSecondButton.layer.borderWidth = 1
            self.imgTitleSecondButton.layer.borderColor = UIColor.systemGray2.cgColor
            
            self.imgTitleThirdButton.tintColor = .systemGray2
            self.imgTitleThirdButton.layer.borderWidth = 1
            self.imgTitleThirdButton.layer.borderColor = UIColor.systemGray2.cgColor
            
            self.imgURLs = ["https://dimg.donga.com/wps/NEWS/IMAGE/2022/04/21/112983704.5.jpg",
                            "https://news.imaeil.com/photos/2019/05/28/2019052816581390757_l.jpg",
                            "https://cdn.dailyimpact.co.kr/news/photo/202104/68343_42316_2142.jpg"]
            self.detailSilverTownSubCV.reloadData()
        
            self.detailSilverTownSubCV.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            
        }.disposed(by: detailSilverTownSubBag)
        
        imgTitleSecondButton.rx.tap.bind{
            
            self.imgTitleFirstButton.tintColor = .systemGray2
            self.imgTitleFirstButton.layer.borderWidth = 1
            self.imgTitleFirstButton.layer.borderColor = UIColor.systemGray2.cgColor
            
            self.imgTitleSecondButton.tintColor = .basicPurple
            self.imgTitleSecondButton.layer.borderWidth = 2
            self.imgTitleSecondButton.layer.borderColor = UIColor.basicPurple.cgColor
            
            self.imgTitleThirdButton.tintColor = .systemGray2
            self.imgTitleThirdButton.layer.borderWidth = 1
            self.imgTitleThirdButton.layer.borderColor = UIColor.systemGray2.cgColor
            
            self.imgURLs = ["https://dimg.donga.com/wps/NEWS/IMAGE/2020/06/03/101324166.5.jpg",
                            "https://www.thedailypost.kr/news/photo/202002/73007_64794_1959.jpg",
                            "https://dimg.donga.com/wps/NEWS/IMAGE/2021/04/08/106312456.2.jpg"]
            self.detailSilverTownSubCV.reloadData()
            
            self.detailSilverTownSubCV.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            
            
        }.disposed(by: detailSilverTownSubBag)
        
        imgTitleThirdButton.rx.tap.bind{
            
            self.imgTitleFirstButton.tintColor = .systemGray2
            self.imgTitleFirstButton.layer.borderWidth = 1
            self.imgTitleFirstButton.layer.borderColor = UIColor.systemGray2.cgColor
            
            self.imgTitleSecondButton.tintColor = .systemGray2
            self.imgTitleSecondButton.layer.borderWidth = 1
            self.imgTitleSecondButton.layer.borderColor = UIColor.systemGray2.cgColor
            
            self.imgTitleThirdButton.tintColor = .basicPurple
            self.imgTitleThirdButton.layer.borderWidth = 2
            self.imgTitleThirdButton.layer.borderColor = UIColor.basicPurple.cgColor
            
            self.imgURLs = ["https://newsimg.sedaily.com/2017/09/03/1OKVUPOCKP_1.jpg",
                            "https://img.etoday.co.kr/pto_db/2014/02/600/20140203051815_403252_836_554.JPG",
                            "https://wimg.mk.co.kr/meet/neds/2015/10/image_readtop_2015_1019968_14458278062191475.jpg"]
            self.detailSilverTownSubCV.reloadData()
            
            self.detailSilverTownSubCV.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            
        }.disposed(by: detailSilverTownSubBag)
        
    }
    
}

extension DetailSilverTownTVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2)
        //print("page = \(page)")
        
        self.detailImgCount.text = "\(page) / \(self.imgURLs.count)"
            // Do whatever with currentPage.
    }
    
}


class DetailSilverTownSubCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
}

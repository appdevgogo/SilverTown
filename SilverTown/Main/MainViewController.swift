//
//  ViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/06.
//

import UIKit
import RxSwift
import RxCocoa


class MainViewController: UIViewController {
    
    @IBOutlet weak var mainFilterCV: UICollectionView!
    private var mainFilterViewModel = MainFilterViewModel()
    private var mainFilterBag = DisposeBag()
    
    
    @IBOutlet weak var mainSilverTownTV: UITableView!
    private var mainSilverTownViewModel = MainSilverTownViewModel()
    private var mainSilverTownBag = DisposeBag()
    
    @IBOutlet weak var mainSilverTownSubCV: UICollectionView!
    private var mainSilverTownSubViewModel = MainSilverTownSubViewModel()
    private var mainSilverTownSubBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindMainFilterCV()
        bindMainSilverTownTV()
        
    }
    
    func bindMainFilterCV() {
        
        var itemOrigin: CGFloat = 15
        var sizeFixArray: [CGFloat] = []
        
        mainFilterViewModel.items.bind(
            to: mainFilterCV.rx.items(
                cellIdentifier: "cell",
                cellType: MainFilterCVC.self)
        ) { index, text, cell in
            
            cell.itemLabel.text = text.item
            cell.itemLabel.textColor = .basicRed
            cell.itemLabel.layer.borderWidth = 1
            cell.itemLabel.layer.borderColor = UIColor.basicRed.cgColor
            cell.itemLabel.layer.masksToBounds = true
            cell.itemLabel.layer.cornerRadius = 15
            cell.itemLabel.sizeToFit()
            
            cell.itemLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            
            cell.contentView.frame.size.width = cell.itemLabel.frame.size.width
            cell.frame.size.width = cell.itemLabel.frame.size.width + 20
            
            switch index {
                
            case sizeFixArray.count :
                cell.frame.origin.x = itemOrigin
                sizeFixArray.append(itemOrigin)
                itemOrigin = itemOrigin + cell.frame.size.width + 15
                
            default :
                cell.frame.origin.x = sizeFixArray[index]
                
            }
            
            
        }.disposed(by: mainFilterBag)
        
        mainFilterViewModel.fetchItem()

    }
    
    func bindMainSilverTownTV() {
        
        mainSilverTownViewModel.items.bind(
            to: mainSilverTownTV.rx.items(
                cellIdentifier: "cell",
                cellType: MainSilverTownTVC.self)
        ) { row, model, cell in
            
            cell.titleLabel.text = model.title
            cell.descriptionLabel.text = model.description
            
            //이미지 3개를 뿌려주면 됨
                        
            
        }.disposed(by: mainSilverTownBag)
        
        mainSilverTownTV
            .rx.setDelegate(self)
            .disposed(by: mainSilverTownBag)
        
        mainSilverTownTV.rx.modelSelected(MainSilverTown.self).bind { town in
            print(town.title)
            print("테스트 페이지 입니다.")
        }.disposed(by: mainSilverTownBag)

        mainSilverTownViewModel.fetchItem()
        
    }
    /*
    func bindMainSilverTownSubCV() {
        
        mainSilverTownSubViewModel.items.bind(
            to: mainFilterCV.rx.items(
                cellIdentifier: "cellcell",
                cellType: MainSilverTownSubCVC.self)
        ) { index, text, cell in
            
            print("여기나오냐냐냥냥냥")
            
            cell.itemImage.image = UIImage(named: "testImage_01")
            
            
        }.disposed(by: mainFilterBag)
        
        mainSilverTownSubViewModel.fetchItem()
        
    }*/

}


extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
    }
    
}

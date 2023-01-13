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
    
    
    @IBOutlet weak var townMainTV: UITableView!
    private var townMainViewModel = TownMainViewModel()
    private var townMainBag = DisposeBag()
    
    @IBOutlet weak var FilterMainCV: UICollectionView!
    private var filterMainViewModel = FilterMainViewModel()
    private var filterMainBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bindTownMainTV()
        bindFilterMainCV()
    }
    
    func bindTownMainTV() {
        
        //Bind items to table
        townMainViewModel.items.bind(
            to: townMainTV.rx.items(
                cellIdentifier: "cell",
                cellType: TownMainTVCell.self)
        ) { row, model, cell in
            
            cell.titleLabel.text = model.title
            cell.descriptionLabel.text = model.description
            
        }.disposed(by: townMainBag)
        
        //Connect Delegate
        townMainTV
            .rx.setDelegate(self)
            .disposed(by: townMainBag)
        
        //Click Event
        townMainTV.rx.modelSelected(TownMain.self).bind { town in
            print(town.title)
            print("테스트 페이지 입니다.")
        }.disposed(by: townMainBag)

        //Fetch itmes
        townMainViewModel.fetchItem()
        
    }
    
    func bindFilterMainCV() {
        
        var itemOrigin: CGFloat = 15
        var sizeFixArray: [CGFloat] = []
        
        filterMainViewModel.items.bind(
            to: FilterMainCV.rx.items(
                cellIdentifier: "cell",
                cellType: FilterMainCVCell.self)
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
            
            
        }.disposed(by: filterMainBag)
        
        filterMainViewModel.fetchItem()

    }

}


extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

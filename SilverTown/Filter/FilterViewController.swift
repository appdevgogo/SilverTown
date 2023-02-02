//
//  FilterViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CoreData


class FilterViewController: UIViewController {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    private var context: NSManagedObjectContext!
    private var filterViewModel = FilterViewModel()
    private var filterSubViewModel = FilterSubViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        bindFilterTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func initSetting() {
        
        addBackButton("arrow.backward", .black, 1)
        saveFilterCoreData()
        
        
    }
    
    func saveFilterCoreData() {
        
        //API로 Filter 상태 받아온후 CoreData에 저장
        let coreDataManager = CoreDataManager(context: context)
        let filterCoreData = Filter(addresses: ["서울특별시", "경기도", "인천광역시", "부산광역시", "대전광역시", "울산광역시", "광주광역시","세종특별자치시", "강원도", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도", "제주특별자치도"], depositMin: 0, depositMax: 100, monthlyFeeMin: 0, monthlyFeeMax: 100, utilityCostMin: 0, utilityCostMax: 100)
        
        coreDataManager.deleteAllData(entityName: "FilterCoreData")
        coreDataManager.saveDataFilter(filter: filterCoreData)
        coreDataManager.getData(entityName: "FilterCoreData")
        
    }
    
    func bindFilterTableView() {
        
        var itemOriginX: CGFloat = 0
        var itemOriginY: CGFloat = 0
        
        filterViewModel.items.bind(
            to: filterTableView.rx.items(
                cellIdentifier: "cell",
                cellType: FilterTableViewCell.self)
            
        ) { row, model, cell in
            
            cell.addressContentHeight.constant = 400
            self.filterTableView.rowHeight = 1200
            cell.addressContentButton.tag = 1
            
            cell.addressContentButton.rx.tap.bind {
                
                switch cell.addressContentButton.tag {
                    
                case 1 :
                    
                    cell.addressContentHeight.constant = 0
                    cell.filterSubCollectionView.layoutIfNeeded()
                    
                    self.filterTableView.beginUpdates()
                    self.filterTableView.rowHeight = 800
                    self.filterTableView.endUpdates()
                    
                    cell.addressContentButton.tag = 0
                    cell.addressContentButton.setImage(UIImage(systemName: "chevron.forward.circle"), for: .normal)
                    
                default:
                    
                    cell.addressContentHeight.constant = cell.filterSubCollectionView.contentSize.height + 140
                    cell.filterSubCollectionView.layoutIfNeeded()
                    
                    self.filterTableView.beginUpdates()
                    self.filterTableView.rowHeight = 1200
                    self.filterTableView.endUpdates()
                    
                    cell.addressContentButton.tag = 1
                    cell.addressContentButton.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
                }
                
                
                /*
                cell.addressContentHeight.constant = cell.filterSubCollectionView.contentSize.height + 140
                cell.filterSubCollectionView.layoutIfNeeded()
                
                self.filterTableView.beginUpdates()
                self.filterTableView.rowHeight = 1200
                self.filterTableView.endUpdates()*/

                
            }.disposed(by: cell.disposeBag)
            
            //==============================>
            cell.filterSubViewModel.items.bind(
                to: cell.filterSubCollectionView.rx.items(
                cellIdentifier: "cell",
                cellType: FilterSubCollectionViewCell.self)
                
                ){ index, model, cell in
                    
                    cell.addressLabel.text = model
                    cell.addressLabel.setfilterAddresses()
                    cell.addressLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
                    
                    cell.contentView.frame.size.width = cell.addressLabel.frame.width
                    cell.frame.size.width = cell.addressLabel.frame.width + 20
                    
                    
                    if (itemOriginX + cell.frame.size.width + 50) > self.filterTableView.frame.width {
                        
                        itemOriginX = 0
                        cell.frame.origin.x = itemOriginX
                        cell.frame.origin.y = itemOriginY + cell.frame.height + 10
                        itemOriginX = itemOriginX + cell.frame.width + 15
                        itemOriginY = itemOriginY + cell.frame.height + 10
                        
                    } else {
                        
                        cell.frame.origin.x = itemOriginX
                        cell.frame.origin.y = itemOriginY
                        itemOriginX = itemOriginX + cell.frame.width + 15
                        
                    }
                    
                    
                    
                }.disposed(by: cell.disposeBag)
            
            cell.filterSubViewModel.fetchItem(data: model.addresses)
            
            //<==============================
        
        }.disposed(by: disposeBag)
        
        filterViewModel.fetchItem()
        
    }
    
    
}


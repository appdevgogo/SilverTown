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
import RxGesture
import CoreData
import MultiSlider


class FilterViewController: UIViewController {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    private var filterViewModel = FilterViewModel()
    private var filterSubViewModel = FilterSubViewModel()
    private var disposeBag = DisposeBag()
    
   // private var context: NSManagedObjectContext!
    private var minMaxArray = [0,0,0,0,0,0]
    private var addressSelectedArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        getAddressSelected()
        bindFilterTableView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        let toSaveData = Filter(address: filterViewModel.addressBase, addressSelected: addressSelectedArray, depositMin: minMaxArray[0], depositMax: minMaxArray[1], monthlyFeeMin: minMaxArray[2], monthlyFeeMax: minMaxArray[3], utilityCostMin: minMaxArray[4], utilityCostMax: minMaxArray[5])
        
        let coreDataManager = CoreDataManager()
        coreDataManager.deleteAllData(entityName: "FilterCoreData")
        coreDataManager.saveDataFilter(filter: toSaveData)
        //coreDataManager.getData(entityName: "FilterCoreData")
        
    }
    
    func initSetting() {
        
        addBackButton("arrow.backward", .black)
        
    }
    
    func getAddressSelected() {
        
        let coreDataManager = CoreDataManager()
        let coreData = coreDataManager.getDataFilter(entityName: "FilterCoreData")
        
        addressSelectedArray = coreData[0].addressSelected
        
    }
    
    func bindFilterTableView() {
        
        var itemOriginX: CGFloat = 0
        var itemOriginY: CGFloat = 0
        
        filterViewModel.items.bind(
            to: filterTableView.rx.items(
                cellIdentifier: "cell",
                cellType: FilterTableViewCell.self)
            
        ) { row, model, cell in
            
            cell.addressContentHeight.constant = 450
            self.filterTableView.rowHeight = 1200
            cell.addressContentButton.tag = 1
            
            cell.depositSlider.value = [CGFloat(model.depositMin), CGFloat(model.depositMax)]
            cell.monthlyFeeSlider.value = [CGFloat(model.monthlyFeeMin), CGFloat(model.monthlyFeeMax)]
            cell.utilityCostSlider.value = [CGFloat(model.utilityCostMin), CGFloat(model.utilityCostMax)]
            
            cell.depositMinLabel.text = "\(model.depositMin)??????"
            cell.depositMaxLabel.text = "\(model.depositMax)??????"
            cell.monthlyFeeMinLabel.text = "\(model.monthlyFeeMin)??????"
            cell.monthlyFeeMaxLabel.text = "\(model.monthlyFeeMax)??????"
            cell.utilityCostMinLabel.text = "\(model.utilityCostMin)??????"
            cell.utilityCostMaxLabel.text = "\(model.utilityCostMax)??????"
            
            cell.depositMinLabel.rx.observe(String.self, "text")
                .subscribe(onNext: { text in
                    let value = text!.replacingOccurrences(of: "??????", with: "")
                    self.minMaxArray[0] = Int(value)!
                }).disposed(by: self.disposeBag)
            
            cell.depositMaxLabel.rx.observe(String.self, "text")
                .subscribe(onNext: { text in
                    let value = text!.replacingOccurrences(of: "??????", with: "")
                    self.minMaxArray[1] = Int(value)!
                }).disposed(by: self.disposeBag)
            
            cell.monthlyFeeMinLabel.rx.observe(String.self, "text")
                .subscribe(onNext: { text in
                    let value = text!.replacingOccurrences(of: "??????", with: "")
                    self.minMaxArray[2] = Int(value)!
                }).disposed(by: self.disposeBag)
            
            cell.monthlyFeeMaxLabel.rx.observe(String.self, "text")
                .subscribe(onNext: { text in
                    let value = text!.replacingOccurrences(of: "??????", with: "")
                    self.minMaxArray[3] = Int(value)!
                    
                }).disposed(by: self.disposeBag)
            
            cell.utilityCostMinLabel.rx.observe(String.self, "text")
                .subscribe(onNext: { text in
                    let value = text!.replacingOccurrences(of: "??????", with: "")
                    self.minMaxArray[4] = Int(value)!
                }).disposed(by: self.disposeBag)
            
            cell.utilityCostMaxLabel.rx.observe(String.self, "text")
                .subscribe(onNext: { text in
                    let value = text!.replacingOccurrences(of: "??????", with: "")
                    self.minMaxArray[5] = Int(value)!
                }).disposed(by: self.disposeBag)
            
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
                
            }.disposed(by: cell.disposeBag)
            
            //==============================>
            cell.filterSubViewModel.items.bind(
                to: cell.filterSubCollectionView.rx.items(
                cellIdentifier: "cell",
                cellType: FilterSubCollectionViewCell.self)
                
                ){ index, model, cell in
                    
                    cell.addressLabel.text = model
                    
                    
                    if self.addressSelectedArray.contains(cell.addressLabel.text!){
                        
                        cell.addressLabel.setfilterAddressSelected()
                        cell.addressLabel.tag = 1
                        
                    } else {
                        
                        cell.addressLabel.setfilterAddressUnSelected()
                        cell.addressLabel.tag = 0
                            
                    }
                    
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
                    
                    
                    cell.addressLabel.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
                        
                        guard let self = self else { return }
                        
                        switch cell.addressLabel.tag {
                            
                        case 0:
                            cell.addressLabel.setfilterAddressSelected()
                            cell.addressLabel.tag = 1
                            self.addressSelectedArray.append(cell.addressLabel.text!)
                            
                            
                        default:
                            cell.addressLabel.setfilterAddressUnSelected()
                            cell.addressLabel.tag = 0
                            //????????? ?????? ??? ?????????
                            self.addressSelectedArray.removeAll(where: { $0 == "\(cell.addressLabel.text!)"})
                        }
                        
                            
                    }).disposed(by: self.disposeBag)

                    
                    /*
                    cell.filterSubCollectionView.rx.bind { element in
                        
                        print(element)
                        
                    }.disposed(by: cell.disposeBag)
                    //<<==========================*/
                    
                    
                }.disposed(by: cell.disposeBag)
            
            cell.filterSubViewModel.fetchItem(data: model.address)
            
            //<==============================
        
        }.disposed(by: disposeBag)
        
        filterViewModel.fetchItem()
        
    }
    
    
}


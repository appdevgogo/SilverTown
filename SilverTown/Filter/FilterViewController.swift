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


class FilterViewController: UIViewController {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    private var filterViewModel = FilterViewModel()
    private var filterSubViewModel = FilterSubViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        bindFilterTableView()
        
    }
    
    func initSetting(){
        
        addBackButton("arrow.backward", .black)
    }
    
    func bindFilterTableView() {
        
        var itemOriginX: CGFloat = 0
        var itemOriginY: CGFloat = 0
        
        filterViewModel.items.bind(
            to: filterTableView.rx.items(
                cellIdentifier: "cell",
                cellType: FilterTableViewCell.self)
            
        ) { row, model, cell in
            
            cell.addressContentButton.rx.tap.bind {
                
                cell.addressContentHeight.constant = cell.filterSubCollectionView.contentSize.height + 140
                cell.filterSubCollectionView.layoutIfNeeded()
                
                self.filterTableView.beginUpdates()
                self.filterTableView.rowHeight = 1200
                self.filterTableView.endUpdates()

                
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


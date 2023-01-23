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
    
    @IBOutlet weak var tableView: UITableView!
    
    private var filterViewModel = FilterViewModel()
    private var filterSubViewModel = FilterSubViewModel()
    
    var ddbag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
    }
    
    func test(){
        
        filterViewModel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: CostumTableViewCell.self)
        ) { row, model, cell in
            
            cell.test = model.title
            
            print("---->> Table ViewModel 실행됨")
            print(model.title)
            
            self.filterSubViewModel.items.bind(
                to : cell.collectionView.rx.items(
                    cellIdentifier: "cell",
                    cellType: CostumCollectionViewCell.self)
            ) {index, model, cell in
                
                print("---->> SubCollectionm ViewModel 실행됨")
                print(model.imageURL)
                
            }.disposed(by: self.ddbag)
            
            self.filterSubViewModel.fetchItem(data: model.imageURLs)
            
        }.disposed(by: ddbag)
        
        filterViewModel.fetchItem()
    
    }
}

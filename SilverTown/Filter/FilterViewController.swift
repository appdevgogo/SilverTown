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


class FilterViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    private var filterViewModel = FilterViewModel()
    //private var filterSubViewModel = FilterSubViewModel()
    var disposeBag = DisposeBag()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindFilterTableView()
        
    }
    
    func bindFilterTableView() {
        
        filterTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        filterViewModel.items.bind(
            to: filterTableView.rx.items(
                cellIdentifier: "cell",
                cellType: FilterTableViewCell.self)
            
        ) { row, model, cell in
            
            cell.titleAddressLabel.text = "테스트"
            

            
        }.disposed(by: disposeBag)
        
        filterViewModel.fetchItem()
        
    }
    
}


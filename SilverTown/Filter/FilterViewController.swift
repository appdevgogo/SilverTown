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
    //private var filterSubViewModel = FilterSubViewModel()
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
        
        filterViewModel.items.bind(
            to: filterTableView.rx.items(
                cellIdentifier: "cell",
                cellType: FilterTableViewCell.self)
            
        ) { row, model, cell in
            

            
        }.disposed(by: disposeBag)
        
        filterViewModel.fetchItem()
        
    }
    
}


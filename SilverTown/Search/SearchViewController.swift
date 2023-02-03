//
//  SearchViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    private var searchViewModel = SearchViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        bindSearchTableView()
        
    }
    
    func initSetting(){
        
        addBackButton("arrow.backward", .black)
    }
    
    func bindSearchTableView() {
        
        searchViewModel.items.bind(
            to: searchTableView.rx.items(
                cellIdentifier: "cell",
                cellType: SearchTableViewCell.self)
            
        ) { row, model, cell in
            
            print("nothing??")
            cell.testLabel.text = "뭐시라"
            cell.testLabel.minMaxLabelInitLayout()
            cell.testLabel.layer.masksToBounds = true
           //cell.testLabel.edgeInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
        }.disposed(by: disposeBag)
        
        searchViewModel.fetchItem()
        
    }
    
}

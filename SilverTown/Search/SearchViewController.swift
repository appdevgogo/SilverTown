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
import CoreData


class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var searchViewModel = SearchViewModel()
    
    var searchResultArray = [Search]()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        saveSearchBaseData()
        bindSearchTableView()
        
    }
    
    func initSetting(){
        
        addBackButton("arrow.backward", .black)
    }
    
    func saveSearchBaseData() {
        
        let coreDataManager = CoreDataManager()
        let toSaveData = [
            Search(title: "SK그레이스힐(Grace Hill)", address: "서울시 강서구 양천로 470", deposit: "4", monthlyFee: "120", utilityCost: "18"),
            Search(title: "더클래식500 실버타운", address: "서울특별시 광진구 자양3동", deposit: "8", monthlyFee: "167", utilityCost: "30"),
            Search(title: "유당마을", address: "경기도 수원시 장안구 조원동 119-3번지", deposit: "3", monthlyFee: "230", utilityCost: "10"),
            Search(title: "하이원빌리지 실버타운", address: "서울특별시 용산구 한강로 2가 55번지", deposit: "2.9", monthlyFee: "136", utilityCost: "15"),
            Search(title: "더헤리티지 실버타운", address: "경기도 성남시 분당구 금곡동 305-2", deposit: "4", monthlyFee: "150", utilityCost: "25")]
        
        coreDataManager.deleteAllData(entityName: "SearchCoreData")
        
        for data in toSaveData{
            coreDataManager.saveDataSearch(search: data)
        }
        
        searchResultArray = toSaveData
        
    }
    
    func bindSearchTableView() {
        
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) //0.5초 기다림
            .distinctUntilChanged() // 같은 아이템을 받지 않는기능
            .subscribe(onNext: { query in
         
                print(query)
                
            }).disposed(by: disposeBag)
        
        
        searchViewModel.items.bind(
            to: searchTableView.rx.items(
                cellIdentifier: "cell",
                cellType: SearchTableViewCell.self)
            
        ) { row, model, cell in
            
            cell.testLabel.text = model.title
            
        }.disposed(by: disposeBag)
        
        searchViewModel.fetchItem(data: searchResultArray)
        
    }
    
    private func input(){
        
    }
}

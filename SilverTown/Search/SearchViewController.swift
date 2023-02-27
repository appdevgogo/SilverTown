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
    private var searchResultArray = [Search]()
    private var searchText = String()
    
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        searchBarLayout()
        saveSearchBaseData()
        bindSearchTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func initSetting(){
        
        addBackButton("arrow.backward", .black)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        searchTableView.keyboardDismissMode = .onDrag
    }
    
    func searchBarLayout() {
        
        
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.setImage(UIImage(systemName: "xmark"), for: .clear, state: .normal)
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "실버타운 이름을 입력하세요", attributes: [NSAttributedString.Key.foregroundColor:UIColor.systemGray2])
        searchBar.backgroundImage = UIImage() //top, bottom border숨기기
        searchBar.layer.borderColor = UIColor.basicBlue.cgColor
        searchBar.layer.borderWidth = 2
        searchBar.layer.cornerRadius = 10
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.font = .systemFont(ofSize: 19)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .basicBlue
        
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
        
    }
    
    func bindSearchTableView() {
        
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance) //0.5초 기다림
            .distinctUntilChanged() // 같은 아이템을 받지 않는기능
            .subscribe(onNext: { query in
                
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
               let managedContext = appDelegate.persistentContainer.viewContext
                
                let predicate = NSPredicate(format: "title CONTAINS %@", query)
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchCoreData")
                fetchRequest.predicate = predicate
                
                do {
                    let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                    
                    self.searchText = query
                    self.searchResultArray = []
                    
                    for data in result {
                        self.searchResultArray.append(
                            Search(
                                title: data.value(forKey: "title") as! String,
                                address: data.value(forKey: "address") as! String,
                                deposit: data.value(forKey: "deposit") as! String,
                                monthlyFee: data.value(forKey: "monthlyFee") as! String,
                                utilityCost: data.value(forKey: "utilityCost") as! String))
                    }
                                      
                } catch {
                    print("Error in updating")
                }
                
                self.searchViewModel.fetchItem(data: self.searchResultArray)
                
            }).disposed(by: disposeBag)
        
        
        searchViewModel.items.bind(
            to: searchTableView.rx.items(
                cellIdentifier: "cell",
                cellType: SearchTableViewCell.self)
            
        ) { row, model, cell in
            
            let range = (model.title as NSString).range(of: self.searchText)

            let attributedText = NSMutableAttributedString.init(string: model.title)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.basicBlue , range: range)
            
            cell.searchResultTitle.attributedText = attributedText
            cell.searchResultAddress.text = model.address
            cell.searchResultOthers.text = "보증금 \(model.deposit)억 / 월이용료 \(model.monthlyFee)만원\n세대관리비 \(model.utilityCost)만원(21평형)"
            cell.searchResultOthers.setLineSpacing(lineSpacing: 3.0)
            
        }.disposed(by: disposeBag)
        
        searchTableView.rx.modelSelected(Search.self).bind { element in
            
            let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "Detail")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }.disposed(by: disposeBag)
        
        searchViewModel.fetchItem(data: searchResultArray)
        
    }
    
}

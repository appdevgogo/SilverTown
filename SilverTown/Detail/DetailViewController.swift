//
//  DetailViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/15.
//
import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailSilverTownTV: UITableView!
    private var detailSilverTownViewModel = DetailSilverTownViewModel()
    
    private var detailSilverTownBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        bindDetailSilverTownTV()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initSetting(){
        
        addBackButton("arrow.backward")
        addRightNavigationButton("heart")
    }
    
    func bindDetailSilverTownTV() {
        
        detailSilverTownViewModel.items.bind(
            to: detailSilverTownTV.rx.items(
                cellIdentifier: "cell",
                cellType: DetailSilverTownTVC.self)
        ) { row, model, cell in
            
            print("djddf")
            
            
        }.disposed(by: detailSilverTownBag)
        
        
        
        detailSilverTownViewModel.fetchItem()
        
        
    }

}

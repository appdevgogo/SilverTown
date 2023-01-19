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
            
            cell.titleLabel.text = model.title
            cell.addressLabel.text = model.address
            cell.subTitleFirstLabel.text = model.subTitleFirst
            cell.subTitleSecondLabel.text = model.subTitleSecond
            cell.subContentFirstLabel.text = model.subContentFirst
            cell.subContentSecondLabel.text = model.subContentSecond
            cell.subOtherLabel.text = model.subOther
            
            print(cell.contentView.frame.size)
            print(cell.titleLabel.frame.size)
            print(cell.frame.size)
            
        }.disposed(by: detailSilverTownBag)
        
        detailSilverTownTV
            .rx.setDelegate(self)
            .disposed(by: detailSilverTownBag)
    
        detailSilverTownViewModel.fetchItem()
        
    }

}


extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 1000
    }
    
}

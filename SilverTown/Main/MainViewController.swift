//
//  ViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/06.
//

import UIKit
import RxSwift
import RxCocoa


class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
        
    }()
    
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    
    
    //------------------->
    @IBOutlet weak var filterMainCV: UICollectionView!
    private var filterMainViewModel = FilterMainViewModel()
    private var filterMainBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(tableView)
        //tableView.frame = view.bounds
        //bindTableData()
        bindFilterMainCV()
    }
    
    func bindTableData() {
        //Bind items to table
        viewModel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self)
        ) { row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageName)
        }.disposed(by: bag)
        
        //Bind a model selected handler
        tableView.rx.modelSelected(Product.self).bind { product in
            print(product.title)
            print("테스트 페이지 입니다.")
        }.disposed(by: bag)

        //Fetch itmes
        viewModel.fetchItem()
        
    }
    
    func bindFilterMainCV() {
        
        var itemOrigin: CGFloat = 15
        var sizeFixArray: [CGFloat] = []
        
        filterMainViewModel.items.bind(
            to: filterMainCV.rx.items(
                cellIdentifier: "cell",
                cellType: FilterMainCVCell.self)
        ) { index, text, cell in
            
            cell.itemLabel.text = text.name
            cell.itemLabel.textColor = .basicRed
            cell.itemLabel.layer.borderWidth = 1
            cell.itemLabel.layer.borderColor = UIColor.basicRed.cgColor
            cell.itemLabel.layer.masksToBounds = true
            cell.itemLabel.layer.cornerRadius = 15
            cell.itemLabel.sizeToFit()
            
            cell.itemLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            
            cell.contentView.frame.size.width = cell.itemLabel.frame.size.width
            cell.frame.size.width = cell.itemLabel.frame.size.width + 20
            
            switch index {
                
            case sizeFixArray.count :
                cell.frame.origin.x = itemOrigin
                sizeFixArray.append(itemOrigin)
                itemOrigin = itemOrigin + cell.frame.size.width + 15
                
            default :
                cell.frame.origin.x = sizeFixArray[index]
                
            }
            
            
        }.disposed(by: filterMainBag)
        
        filterMainViewModel.fetchItem()

    }

}



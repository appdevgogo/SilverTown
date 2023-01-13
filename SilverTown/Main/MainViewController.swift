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
    private var testViewModel = FilterMainViewModel()
    private var testBag = DisposeBag()
    

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
        
        var itemOrigin: CGFloat = 20
        //var sizeFixFlag: Bool = false
        var sizeFixArray: [CGFloat] = []
        
        testViewModel.items.bind(
            to: filterMainCV.rx.items(
                cellIdentifier: "cell",
                cellType: FilterMainCVCell.self)
        ) { index, text, cell in
            
            cell.itemLabel.text = text.name
            cell.itemLabel.backgroundColor = .green
            cell.itemLabel.layer.cornerRadius = 10
            cell.itemLabel.layer.masksToBounds = true
            cell.itemLabel.sizeToFit()
            
            cell.contentView.frame.size.width = cell.itemLabel.frame.size.width
            cell.frame.size.width = cell.itemLabel.frame.size.width
            
            print("--->카운드")
            print(sizeFixArray.count)
            print(index)
            
            if index == sizeFixArray.count {
                
                cell.frame.origin.x = itemOrigin
                sizeFixArray.append(itemOrigin)
                itemOrigin = itemOrigin + cell.itemLabel.frame.size.width + 10
                
            } else {
                
                cell.frame.origin.x = sizeFixArray[index]
                
            }
            
            print(text.name)
            print(cell.frame.origin)
            print(cell.itemLabel.frame.size)
            print(cell.contentView.frame.size)
            print(cell.frame.size)
            
            print(sizeFixArray)
            print(self.filterMainCV.collectionViewLayout.collectionViewContentSize)
            print(self.filterMainCV.contentSize)
            
            
        }.disposed(by: bag)
        
        testViewModel.fetchItem()

    }

}


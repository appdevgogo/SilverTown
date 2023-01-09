//
//  ViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/06.
//

import UIKit
import RxSwift
import RxCocoa

struct Product {
    let imageName: String
    let title: String
}

struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    
    func fetchItem(){
        let products = [
            Product(imageName: "imageName1", title: "title1"),
            Product(imageName: "imageName2", title: "title2"),
            Product(imageName: "imageName3", title: "title3"),
            Product(imageName: "imageName4", title: "title4"),
            Product(imageName: "imageName5", title: "title5"),
            Product(imageName: "imageName6", title: "title6"),
            Product(imageName: "imageName7", title: "title7"),
        ]
        
        items.onNext(products)
        items.onCompleted()
    }
    
}

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
        
    }()
    
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableData()
    }
    
    private func initSetting () {
        
        print("--->> initSetting 시작되었습니다.")
        
        let Storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let VC = Storyboard.instantiateViewController(identifier: "Main") as? ViewController else { return }
        //VC.modalPresentationStyle = .fullScreen // 풀스크린으로 설정
        self.present(VC, animated: false, completion: nil)
        // 뷰가 등장하는 애니메이션 효과인 animated는 false로 설정
        
        
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

}


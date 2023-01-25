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
    
    @IBOutlet weak var mainFilterCollectionView: UICollectionView!
    private var mainFilterViewModel = MainFilterViewModel()
    //private var mainFilterBag = DisposeBag()
    
    @IBOutlet weak var mainSilverTownTableView: UITableView!
    private var mainSilverTownViewModel = MainSilverTownViewModel()
    private var disposeBag = DisposeBag()
    
    let mainBottomButtonSearch = UIButton()
    let mainBottomButtonBookMark = UIButton()
    let mainBottomButtonFilter = UIButton()
    
    private var safeAreaVertical: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindMainFilterCollectionView()
        bindMainSilverTownTableView()
        addMainBottomButtons()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func bindMainFilterCollectionView() {
        
        var itemOrigin: CGFloat = 15
        var sizeFixArray: [CGFloat] = []
        
        mainFilterViewModel.items.bind(
            to: mainFilterCollectionView.rx.items(
                cellIdentifier: "cell",
                cellType: MainFilterCollectionViewCell.self)
        ) { index, text, cell in
            
            cell.itemLabel.text = text.item
            cell.itemLabel.textColor = .basicRed
            cell.itemLabel.layer.borderWidth = 1
            cell.itemLabel.layer.borderColor = UIColor.basicRed.cgColor
            cell.itemLabel.layer.cornerRadius = 15
            cell.itemLabel.layer.masksToBounds = true
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
            
        }.disposed(by: disposeBag)
        
        mainFilterViewModel.fetchItem()

    }
    
    func bindMainSilverTownTableView() {
        
        mainSilverTownTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        mainSilverTownViewModel.items.bind(
            to: mainSilverTownTableView.rx.items(
                cellIdentifier: "cell",
                cellType: MainSilverTownTableViewCell.self)
            
        ) { row, model, cell in
            
            //print("------------->> mainSilverTownTableView 시작, row : \(row) ")
            
            cell.titleLabel.text = model.title
            cell.descriptionLabel.setLineSpacing(lineSpacing: 5.0)
            cell.descriptionLabel.text = model.description
            cell.separatorLabel.layer.cornerRadius = 3
            cell.separatorLabel.layer.masksToBounds = true
            
            let mainSilverTownSubViewModel = MainSilverTownSubViewModel()

            mainSilverTownSubViewModel.items.bind(
                to: cell.mainSilverTownSubCollectionView.rx.items(
                    cellIdentifier: "cell",
                    cellType: MainSilverTownSubCollectionViewCell.self)
                
            ) { index, model, cell in
                
                cell.itemImage.layer.cornerRadius = 25
                
                //print("================== mainSilverTownSubViewModel ==>>")
                
                switch model.imageURL {
                     
                case "none", "":
                    print("No image available")
                     
                default :
                    guard let url = URL(string: model.imageURL) else { return }
                    cell.itemImage.kf.setImage(with: url)
                    
                 }
                
            }.disposed(by: self.disposeBag)
            
            cell.mainSilverTownSubCollectionView.rx.modelSelected(MainSilverTownSub.self).bind { element in
                
                let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
                guard let controller = storyBoard.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {return}
                self.navigationController?.pushViewController(controller, animated: true)
             
            }.disposed(by: self.disposeBag)
            
            mainSilverTownSubViewModel.fetchItem(data: model.imageURLs)
            
        }.disposed(by: disposeBag)
        
        mainSilverTownTableView.rx.modelSelected(MainSilverTown.self).bind { element in
            
            let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "Detail")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }.disposed(by: disposeBag)
        
        mainSilverTownViewModel.fetchItem()
        
    }
    
    func addMainBottomButtons(){
        
        print(mainSilverTownTableView.frame.size)
        print(UIScreen.main.bounds.size)
        
        
        let window = UIApplication.shared.windows.first
        let safeAreaTop = window?.safeAreaInsets.top
        let safeAreaBottom = window?.safeAreaInsets.bottom
        
        safeAreaVertical = safeAreaTop! + safeAreaBottom!
        
        mainBottomButtonSearch.addMainBottomButton(imageName: "main_bottom_btn_search", borderColor: UIColor.basicBlue.cgColor, title: "검색", tintColr: .basicBlue)
        mainBottomButtonSearch.frame = CGRect(x: UIScreen.main.bounds.width / 5 - 35, y: UIScreen.main.bounds.height - 130 - safeAreaVertical, width: 70, height: 60)
        mainSilverTownTableView.addSubview(mainBottomButtonSearch)
        
        
        mainBottomButtonBookMark.addMainBottomButton(imageName: "main_bottom_btn_heart", borderColor: UIColor.basicPurple.cgColor, title: "즐겨찾기", tintColr: .basicPurple)
        mainBottomButtonBookMark.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 35, y: UIScreen.main.bounds.height - 130 - safeAreaTop! - safeAreaBottom!, width: 70, height: 60)
        mainSilverTownTableView.addSubview(mainBottomButtonBookMark)
        
        mainBottomButtonFilter.addMainBottomButton(imageName: "main_bottom_btn_filter", borderColor: UIColor.basicRed.cgColor, title: "검색", tintColr: .basicRed)
        mainBottomButtonFilter.frame = CGRect(x: UIScreen.main.bounds.width * 4/5 - 35, y: UIScreen.main.bounds.height - 130 - safeAreaVertical, width: 70, height: 60)
        mainSilverTownTableView.addSubview(mainBottomButtonFilter)

    }

}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let off = mainSilverTownTableView.contentOffset.y
        
        mainBottomButtonSearch.frame = CGRect(x: UIScreen.main.bounds.width / 5 - 35, y: off + UIScreen.main.bounds.height - 130 - safeAreaVertical, width: mainBottomButtonSearch.frame.size.width, height: mainBottomButtonSearch.frame.size.height)
        
        mainBottomButtonBookMark.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 35, y: off + UIScreen.main.bounds.height - 130 - safeAreaVertical, width: mainBottomButtonBookMark.frame.size.width, height: mainBottomButtonBookMark.frame.size.height)
        
        mainBottomButtonFilter.frame = CGRect(x: UIScreen.main.bounds.width * 4/5 - 35, y: off + UIScreen.main.bounds.height - 130 - safeAreaVertical, width: mainBottomButtonFilter.frame.size.width, height: mainBottomButtonFilter.frame.size.height)
        
        
    }
    
}

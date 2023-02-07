//
//  ViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/06.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData


class MainViewController: UIViewController {
    
    @IBOutlet weak var mainFilterCollectionView: UICollectionView!
    @IBOutlet weak var mainSilverTownTableView: UITableView!
    
    private var mainFilterViewModel = MainFilterViewModel()
    private var mainSilverTownViewModel = MainSilverTownViewModel()
    private var disposeBag = DisposeBag()
    
    private var context: NSManagedObjectContext!
    private var safeAreaVertical: CGFloat = 0.0
    //private var addressArray = [String]()
    private var mainFilterData = [MainFilter]()
    
    let mainBottomButtonSearch = UIButton()
    let mainBottomButtonBookmark = UIButton()
    let mainBottomButtonFilter = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFilterMain()
        bindMainFilterCollectionView()
        bindMainSilverTownTableView()
        addMainBottomButtons()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //getFilterMain()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func getFilterMain() {
        
        let coreDataManager = CoreDataManager(context: context)
        let coreData = coreDataManager.getDataFilter(entityName: "FilterCoreData")
        //var addressArray = coreData[0].address
       // var addressSelectedArray = coreData[0].addressSelected
        var addressIndex = [Int]()
        var text: String
        
        switch coreData[0].addressSelected.count {
            
        case 0:
            text = "모든지역"
            
        default:
            for item in coreData[0].addressSelected {
                if let index = coreData[0].address.firstIndex(of: item) {
                    addressIndex.append(index)
                }
            }
            
            text = "\(coreData[0].address[addressIndex.min()!]) 등 \(coreData[0].addressSelected.count)지역"
        }
        
        
        
        mainFilterData = [
            MainFilter(item: "\(text)"),
            MainFilter(item: "보증금 \(coreData[0].depositMin)~\(coreData[0].depositMax)억원"),
            MainFilter(item: "월이용료 \(coreData[0].monthlyFeeMin)~\(coreData[0].monthlyFeeMax)만원"),
            MainFilter(item: "월관리비 \(coreData[0].utilityCostMin)~\(coreData[0].utilityCostMax)만원")
        ]
        
        
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
            cell.itemLabel.clipsToBounds = true
            cell.itemLabel.sizeToFit()
            
            cell.itemLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            
            cell.contentView.frame.size.width = cell.itemLabel.frame.width
            cell.frame.size.width = cell.itemLabel.frame.width + 20
            
            switch index {
                
            case sizeFixArray.count :
                cell.frame.origin.x = itemOrigin
                sizeFixArray.append(itemOrigin)
                itemOrigin = itemOrigin + cell.frame.size.width + 10 //간격
                
            default :
                cell.frame.origin.x = sizeFixArray[index]
                
            }
            
        }.disposed(by: disposeBag)
        
        mainFilterViewModel.fetchItem(data: mainFilterData)

    }
    
    func bindMainSilverTownTableView() {
        
        mainSilverTownTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        mainSilverTownViewModel.items.bind(
            to: mainSilverTownTableView.rx.items(
                cellIdentifier: "cell",
                cellType: MainSilverTownTableViewCell.self)
            
        ) { row, model, cell in
            
            cell.titleLabel.text = model.title
            cell.descriptionLabel.setLineSpacing(lineSpacing: 5.0)
            cell.descriptionLabel.text = model.description
            cell.separatorLabel.layer.cornerRadius = 3
            cell.separatorLabel.clipsToBounds = true
            
            cell.mainSilverTownSubCollectionView.rx.modelSelected(MainSilverTownSub.self).bind { element in
                
                let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
                guard let controller = storyBoard.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {return}
                self.navigationController?.pushViewController(controller, animated: true)
             
            }.disposed(by: self.disposeBag)
            
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
        
        //print(mainSilverTownTableView.frame.size)
        //print(UIScreen.main.bounds.size)
        
        let window = UIApplication.shared.windows.first
        let safeAreaTop = window?.safeAreaInsets.top
        let safeAreaBottom = window?.safeAreaInsets.bottom
        
        safeAreaVertical = safeAreaTop! + safeAreaBottom!
        
        //----------
        mainBottomButtonSearch.addMainBottomButton(imageName: "main_bottom_btn_search", borderColor: UIColor.basicBlue.cgColor, title: "검색", titleColor: .basicBlue)
        mainBottomButtonSearch.frame = CGRect(x: UIScreen.main.bounds.width / 5 - 35, y: UIScreen.main.bounds.height - 130 - safeAreaVertical, width: 70, height: 60)
        mainSilverTownTableView.addSubview(mainBottomButtonSearch)
        
        mainBottomButtonSearch.rx.tap.bind{
            
            let storyBoard = UIStoryboard(name: "Search", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "Search")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }.disposed(by: disposeBag)
        
        //----------
        mainBottomButtonBookmark.addMainBottomButton(imageName: "main_bottom_btn_heart", borderColor: UIColor.basicPurple.cgColor, title: "즐겨찾기", titleColor: .basicPurple)
        mainBottomButtonBookmark.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 35, y: UIScreen.main.bounds.height - 130 - safeAreaTop! - safeAreaBottom!, width: 70, height: 60)
        mainSilverTownTableView.addSubview(mainBottomButtonBookmark)
        
        mainBottomButtonBookmark.rx.tap.bind{
            
            let storyBoard = UIStoryboard(name: "Bookmark", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "Bookmark")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }.disposed(by: disposeBag)
        
        //----------
        mainBottomButtonFilter.addMainBottomButton(imageName: "main_bottom_btn_filter", borderColor: UIColor.basicRed.cgColor, title: "필터", titleColor: .basicRed)
        mainBottomButtonFilter.frame = CGRect(x: UIScreen.main.bounds.width * 4/5 - 35, y: UIScreen.main.bounds.height - 130 - safeAreaVertical, width: 70, height: 60)
        mainSilverTownTableView.addSubview(mainBottomButtonFilter)
        
        mainBottomButtonFilter.rx.tap.bind{
            
            let storyBoard = UIStoryboard(name: "Filter", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "Filter")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }.disposed(by: disposeBag)

    }

}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        mainBottomButtonSearch.isHidden = true
        mainBottomButtonBookmark.isHidden = true
        mainBottomButtonFilter.isHidden = true
        
        mainFilterCollectionView.layer.addBorder(edge: UIRectEdge.bottom, color: .systemGray6, thickness: 1.0)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        mainFilterCollectionView.layer.addBorder(edge: UIRectEdge.bottom, color: .white, thickness: 1.0)
        
        let off = mainSilverTownTableView.contentOffset.y
        
        mainBottomButtonSearch.fadeTransition(0.2)
        mainBottomButtonSearch.isHidden = false
        mainBottomButtonSearch.frame = CGRect(x: UIScreen.main.bounds.width / 5 - 35, y: off + UIScreen.main.bounds.height - 130 - safeAreaVertical, width: mainBottomButtonSearch.frame.size.width, height: mainBottomButtonSearch.frame.size.height)
        
        mainBottomButtonBookmark.fadeTransition(0.3)
        mainBottomButtonBookmark.isHidden = false
        mainBottomButtonBookmark.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 35, y: off + UIScreen.main.bounds.height - 130 - safeAreaVertical, width: mainBottomButtonBookmark.frame.size.width, height: mainBottomButtonBookmark.frame.size.height)
        
        mainBottomButtonFilter.fadeTransition(0.4)
        mainBottomButtonFilter.isHidden = false
        mainBottomButtonFilter.frame = CGRect(x: UIScreen.main.bounds.width * 4/5 - 35, y: off + UIScreen.main.bounds.height - 130 - safeAreaVertical, width: mainBottomButtonFilter.frame.size.width, height: mainBottomButtonFilter.frame.size.height)
        
    }
    
}

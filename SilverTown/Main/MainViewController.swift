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
import FirebaseDatabase

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainFilterCollectionView: UICollectionView!
    @IBOutlet weak var mainSilverTownTableView: UITableView!
    //@IBOutlet weak var addressContentWidth: NSLayoutConstraint!
    
    private var mainFilterViewModel = MainFilterViewModel()
    private var mainSilverTownViewModel = MainSilverTownViewModel()
    private var disposeBag = DisposeBag()
    
  //  private var context: NSManagedObjectContext!
    private var safeAreaVertical: CGFloat = 0.0
    //private var addressArray = [String]()
    private var mainFilterData = [MainFilter]()
    //private var mainFilterSizeFixArray: [CGFloat] = []
    //private var mainFilterItemOrigin: CGFloat = 15
    private var mainSilverTownData = [MainSilverTown]()
    
    let mainBottomButtonSearch = UIButton()
    let mainBottomButtonBookmark = UIButton()
    let mainBottomButtonFilter = UIButton()
    
    let firebaseData = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMainSilverTownData()
        bindMainFilterCollectionView()
        bindMainSilverTownTableView()
        addMainBottomButtons()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        //mainFilterSizeFixArray = []
        //mainFilterItemOrigin = 15
        getFilterMain()
        mainFilterViewModel.fetchItem(data: mainFilterData)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    func getMainSilverTownData() {
        /*
        firebaseData.child("data").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
          print()
            
        });*/
        
        firebaseData.child("data").observeSingleEvent(of: .value, with: { snapshot in
         
            guard let snapData = snapshot.value as? [String: Any] else {return}
            
            for item in snapData.values {

                guard let source = item as? [String: Any] else {return}
                guard let imgSource = source["imageURLs"] as? [String: String] else {return}
         
                let dataTo = MainSilverTown(
                    title: source["title"] as! String,
                    description: source["description"] as! String,
                    imageURLs: [
                        MainSilverTownSub(imageURL: imgSource.values.sorted()[0]),
                        MainSilverTownSub(imageURL: imgSource.values.sorted()[1]),
                        MainSilverTownSub(imageURL: imgSource.values.sorted()[2])])
                
                self.mainSilverTownData.append(dataTo)
            }
            
            self.mainSilverTownViewModel.fetchItem(data: self.mainSilverTownData)
            

        }) { error in
            
          print(error.localizedDescription)
            
        }
/*
        firebaseData.child("data").observeSingleEvent(of: .value) { snapshot in
            
            guard let snapData = snapshot.value as? [String: Any] else {return}
            
            /*
            MainSilverTown(
                title: "????????????",
                description: "????????? 3??? / ???????????? 230??????\n??????????????? 10??????(20??????)",
                imageURLs: [MainSilverTownSub(imageURL:"https://newsimg.sedaily.com/2017/09/03/1OKVUPOCKP_1.jpg"),
                            MainSilverTownSub(imageURL:"https://img.etoday.co.kr/pto_db/2014/02/600/20140203051815_403252_836_554.JPG"),
                            MainSilverTownSub(imageURL:"https://wimg.mk.co.kr/meet/neds/2015/10/image_readtop_2015_1019968_14458278062191475.jpg")])
            ]*/
        }*/
        
    }
    
    func getFilterMain() {
        
        let coreDataManager = CoreDataManager()
        let coreData = coreDataManager.getDataFilter(entityName: "FilterCoreData")
        var addressIndex = [Int]()
        var text: String
        
        switch coreData[0].addressSelected.count {
    
        case coreData[0].address.count:
            text = "????????????"
            
        case 0:
            text = "??????????????????"
            
        case 1:
            text = "\(coreData[0].addressSelected[0])"
            
        default:
            for item in coreData[0].addressSelected {
                if let index = coreData[0].address.firstIndex(of: item) {
                    addressIndex.append(index)
                }
            }
            
            text = "\(coreData[0].address[addressIndex.min()!]) ??? \(coreData[0].addressSelected.count) ??????"
        }
        
        mainFilterData = [
            MainFilter(item: "\(text)"),
            MainFilter(item: "????????? \(coreData[0].depositMin)~\(coreData[0].depositMax)??????"),
            MainFilter(item: "???????????? \(coreData[0].monthlyFeeMin)~\(coreData[0].monthlyFeeMax)??????"),
            MainFilter(item: "???????????? \(coreData[0].utilityCostMin)~\(coreData[0].utilityCostMax)??????")
        ]
        
        
    }
    
    func bindMainFilterCollectionView() {
        
        //???????????? ???????????? ???????????? ?????? ???(??????)
        let layout = mainFilterCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 128, height: 50)
        
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
            cell.itemLabel.clipsToBounds = true //???????????? ????????? ??????
            cell.itemLabel.sizeToFit()
            
            cell.itemLabel.edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            
            /*
            cell.contentView.frame.size.width = cell.itemLabel.frame.width
            cell.frame.size.width = cell.itemLabel.frame.width + 20
            
            switch index {
                
            case self.mainFilterSizeFixArray.count :
                print("************ ?????? ************")
                print(self.mainFilterItemOrigin)
                
                cell.frame.origin.x = self.mainFilterItemOrigin
                self.mainFilterSizeFixArray.append(self.mainFilterItemOrigin)
                self.mainFilterItemOrigin = self.mainFilterItemOrigin + cell.frame.size.width + 10 //??????
                
            default :
                cell.frame.origin.x = self.mainFilterSizeFixArray[index]
                
            }*/

        }.disposed(by: disposeBag)
        
       // mainFilterViewModel.fetchItem(data: mainFilterData)
        
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
        
        //mainSilverTownViewModel.fetchItem()
        
    }
    
    func addMainBottomButtons(){
        
        let window = UIApplication.shared.windows.first
        let safeAreaTop = window?.safeAreaInsets.top
        let safeAreaBottom = window?.safeAreaInsets.bottom
        
        safeAreaVertical = safeAreaTop! + safeAreaBottom!
        
        //----------
        mainBottomButtonSearch.addMainBottomButton(imageName: "main_bottom_btn_search", borderColor: UIColor.basicBlue.cgColor, title: "??????", titleColor: .basicBlue)
        mainBottomButtonSearch.frame = CGRect(x: UIScreen.main.bounds.width / 5 - 35, y: UIScreen.main.bounds.height - 130 - safeAreaVertical, width: 70, height: 60)
        mainSilverTownTableView.addSubview(mainBottomButtonSearch)
        
        mainBottomButtonSearch.rx.tap.bind{
            
            let storyBoard = UIStoryboard(name: "Search", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "Search")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }.disposed(by: disposeBag)
        
        //----------
        mainBottomButtonBookmark.addMainBottomButton(imageName: "main_bottom_btn_heart", borderColor: UIColor.basicPurple.cgColor, title: "????????????", titleColor: .basicPurple)
        mainBottomButtonBookmark.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 35, y: UIScreen.main.bounds.height - 130 - safeAreaTop! - safeAreaBottom!, width: 70, height: 60)
        mainSilverTownTableView.addSubview(mainBottomButtonBookmark)
        
        mainBottomButtonBookmark.rx.tap.bind{
            
            let storyBoard = UIStoryboard(name: "Bookmark", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "Bookmark")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }.disposed(by: disposeBag)
        
        //----------
        mainBottomButtonFilter.addMainBottomButton(imageName: "main_bottom_btn_filter", borderColor: UIColor.basicRed.cgColor, title: "??????", titleColor: .basicRed)
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

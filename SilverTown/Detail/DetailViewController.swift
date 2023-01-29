//
//  DetailViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/15.
//
import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailSilverTownTableView: UITableView!
    private var detailSilverTownViewModel = DetailSilverTownViewModel()
    //private var detailSilverTownSubImageViewModel = DetailSilverTownSubImageViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        bindDetailSilverTownTableView()
        
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
        
        addBackButton("arrow.backward", .black)
        addRightNavigationButton("heart")
    }
    
    func bindDetailSilverTownTableView() {
        
        detailSilverTownViewModel.items.bind(
            to: detailSilverTownTableView.rx.items(
                cellIdentifier: "cell",
                cellType: DetailSilverTownTableViewCell.self)
        ) { row, model, cell in
            
            cell.titleLabel.text = model.title
            cell.addressLabel.text = model.address
            cell.subTitleFirstLabel.text = model.subTitleFirst
            cell.subTitleSecondLabel.text = model.subTitleSecond
            cell.subContentFirstLabel.text = model.subContentFirst
            cell.subContentSecondLabel.text = model.subContentSecond
            cell.subOtherLabel.text = model.subOther
            cell.imageCount = model.imageURLs.count
            
            // Buttons -------------->>
            cell.imageTitleFirstButton.rx.tap.bind{
                
                cell.detailSilverTownSubImageViewModel.fetchItem(data: model.imageURLsFirst)
                
            }.disposed(by: self.disposeBag)
            
            cell.imageTitleSecondButton.rx.tap.bind{
                
                cell.detailSilverTownSubImageViewModel.fetchItem(data: model.imageURLsSecond)
                
            }.disposed(by: self.disposeBag)
            
            cell.imageTitleThirdButton.rx.tap.bind{
                
                cell.detailSilverTownSubImageViewModel.fetchItem(data: model.imageURLsThird)
                
            }.disposed(by: self.disposeBag)
            
            cell.youtubeFirstImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in
                
                let storyBoard = UIStoryboard(name: "YoutubePopup", bundle: nil)
                guard let controller = storyBoard.instantiateViewController(withIdentifier: "YoutubePopup") as? YoutubePopupViewController else {return}
                
                controller.youtubeID = model.youtubeIDs[0]
                self.navigationController?.pushViewController(controller, animated: false)
                
            }).disposed(by: self.disposeBag)
            
            cell.youtubeSecondImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in
                
                let storyBoard = UIStoryboard(name: "YoutubePopup", bundle: nil)
                guard let controller = storyBoard.instantiateViewController(withIdentifier: "YoutubePopup") as? YoutubePopupViewController else {return}
                
                controller.youtubeID = model.youtubeIDs[1]
                self.navigationController?.pushViewController(controller, animated: false)
                
            }).disposed(by: self.disposeBag)
            // <<-------------------------------
            
            guard let url = URL(string: "https://img.youtube.com/vi/\(model.youtubeIDs[0])/0.jpg") else { return }
            
            let processor = DownsamplingImageProcessor(size: cell.youtubeFirstImageView.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            
            cell.youtubeFirstImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "smile"),
                options: [.processor(processor), .loadDiskFileSynchronously, .cacheOriginalImage, .transition(.fade(0.25))])
            
            guard let url = URL(string: "https://img.youtube.com/vi/\(model.youtubeIDs[1])/0.jpg") else { return }
            
            cell.youtubeSecondImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "smile"),
                options: [.processor(processor), .loadDiskFileSynchronously, .cacheOriginalImage, .transition(.fade(0.25))])
            
            
            //============ Sub CollectionView 구분선 ==============>>
            cell.detailSilverTownSubImageViewModel.items.bind(
                to: cell.detailSilverTownSubImageCollectionView.rx.items(
                    cellIdentifier: "cell",
                    cellType: DetailSilverTownSubImageCollectionViewCell.self)

            ){ index, model, cell in
                
                cell.itemImage.layer.cornerRadius = 15
                
                switch model.imageURL {
                case "none", "":
                    print("No image available")
                default :
                    guard let url = URL(string: model.imageURL) else { return }
                    cell.itemImage.kf.setImage(with: url)
                 }
                    
            }.disposed(by: cell.disposeBag)
            
            cell.detailSilverTownSubImageViewModel.fetchItem(data: model.imageURLs)
            
            cell.detailSilverTownSubImageCollectionView.rx.modelSelected(DetailSilverTownSubImage.self).bind { element in
                
                let storyBoard = UIStoryboard(name: "ImagePopup", bundle: nil)
                guard let controller = storyBoard.instantiateViewController(withIdentifier: "ImagePopup") as? ImagePopupViewController else {return}
                guard let url = URL(string: element.imageURL) else { return }
                controller.url = url
                self.navigationController?.pushViewController(controller, animated: false)
                
            }.disposed(by: cell.disposeBag)
            //<<==========================
            
        }.disposed(by: disposeBag)
        
        detailSilverTownViewModel.fetchItem()
        
    }


}


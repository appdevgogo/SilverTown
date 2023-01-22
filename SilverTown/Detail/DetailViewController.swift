//
//  DetailViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/15.
//
import UIKit
import RxSwift
import RxCocoa
import Kingfisher

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
            cell.imageURLs = model.imageURLs
            
            guard let url = URL(string: model.youtubeURLs[0]) else { return }
            
            let processor = DownsamplingImageProcessor(size: cell.youtubeFirstImageView.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            
            cell.youtubeFirstImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "smile"),
                options: [.processor(processor), .loadDiskFileSynchronously, .cacheOriginalImage, .transition(.fade(0.25))])
            
            guard let url = URL(string: model.youtubeURLs[1]) else { return }
            
            cell.youtubeSecondImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "smile"),
                options: [.processor(processor), .loadDiskFileSynchronously, .cacheOriginalImage, .transition(.fade(0.25))])
            
            print(self.detailSilverTownTV.frame.size)
            print(cell.frame.size)
            print(cell.contentView.frame.size)
            print(cell.youtubeFirstImageView.frame.size)
            
            
        }.disposed(by: detailSilverTownBag)
        
        detailSilverTownViewModel.fetchItem()
        
    }

}


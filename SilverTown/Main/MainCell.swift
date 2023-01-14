//
//  MainCustomCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/12.
//

import UIKit
import RxSwift
import RxCocoa

class MainFilterCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemLabel: PaddingLabel!
    
}


class MainSilverTownTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var mainSilverTownSubCV: UICollectionView!
    private var mainSilverTownSubViewModel = MainSilverTownSubViewModel()
    private var mainSilverTownSubBag = DisposeBag()

    @IBOutlet weak var separatorLabel: UILabel!
    
    override func awakeFromNib() {
        bindTest()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.backgroundColor = UIColor.white
            
        } else {
            contentView.backgroundColor = UIColor.white
        }
        
    }
    
    func bindTest(){
        
        mainSilverTownSubViewModel.items.bind(
            to: mainSilverTownSubCV.rx.items(
                cellIdentifier: "cell",
                cellType: MainSilverTownSubCVC.self)
        ){ index, model, cell in
            
            cell.itemImage.layer.cornerRadius = 25
            print(index)
            
            //cell.itemImage.load(url: URL(string: model.imageURL[1])!)

        }.disposed(by: mainSilverTownSubBag)
        
        mainSilverTownSubViewModel.fetchItem()
        
    }
    
    
}


class MainSilverTownSubCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
}


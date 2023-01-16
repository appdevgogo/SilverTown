//
//  MainCustomCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/12.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

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
    
    var imgURLs: [String] = []
    
    override func awakeFromNib() {
        
        bindMainSilverTownSubCV()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.backgroundColor = UIColor.white
            
        } else {
            contentView.backgroundColor = UIColor.white
            
        }
        
    }
    
    func bindMainSilverTownSubCV(){
        
        mainSilverTownSubViewModel.items.bind(
            to: mainSilverTownSubCV.rx.items(
                cellIdentifier: "cell",
                cellType: MainSilverTownSubCVC.self)
        ){ index, model, cell in
            
            print("------->")
            print(index)
            print(self.imgURLs)
            //print(self.titleLabel.text!)
            //print(model.imageURL)
            
            cell.itemImage.layer.cornerRadius = 25
            
            switch self.imgURLs[index] {
                 
            case "none", "":
                print("No image available")
                 
            default :
                guard let url = URL(string: self.imgURLs[index]) else { return }
                cell.itemImage.kf.setImage(with: url)
                 
             }
                
        }.disposed(by: mainSilverTownSubBag)
        
        mainSilverTownSubCV.rx.modelSelected(MainSilverTownSub.self).bind { element in
            
            print("클릭 이벤트")
            /*
            let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
            guard let controller = storyBoard.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {return}
            self.navigationController?.pushViewController(controller, animated: true)*/
         
        }.disposed(by: mainSilverTownSubBag)
        
        mainSilverTownSubViewModel.fetchItem()
        
    }
    
}


class MainSilverTownSubCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
}


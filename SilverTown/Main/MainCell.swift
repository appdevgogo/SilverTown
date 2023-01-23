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

class MainFilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemLabel: PaddingLabel!
    
}


class MainSilverTownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var mainSilverTownSubCollectionView: UICollectionView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.backgroundColor = UIColor.white
            
        } else {
            contentView.backgroundColor = UIColor.white
            
        }
        
    }
    
}


class MainSilverTownSubCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
}


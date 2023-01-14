//
//  MainCustomCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/12.
//

import UIKit

class MainFilterCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemLabel: PaddingLabel!
    
}


class MainSilverTownTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        if selected {
            
            contentView.backgroundColor = UIColor.systemGray6
            
        } else {
            
            contentView.backgroundColor = UIColor.white
        }
        
    }
    
}


class MainSilverTownSubCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
}


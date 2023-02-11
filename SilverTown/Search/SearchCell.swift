//
//  SearchCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchResultTitle: UILabel!
    @IBOutlet weak var searchResultAddress: UILabel!
    @IBOutlet weak var searchResultOthers: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.backgroundColor = UIColor.white
            
        } else {
            contentView.backgroundColor = UIColor.white
            
        }
        
    }
}

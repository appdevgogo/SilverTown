//
//  BookmarkCell.swift
//  SilverTown
//
//  Created by yyjweber on 2023/02/11.
//

import Foundation
import UIKit
import RxSwift


class BookmarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookmarkTitleLabel: UILabel!
    @IBOutlet weak var bookmarkAddressLabel: UILabel!
    @IBOutlet weak var bookmarkDeleteButton: UIButton!
    
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
       super.prepareForReuse()
       disposeBag = DisposeBag()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.backgroundColor = UIColor.white
            
        } else {
            contentView.backgroundColor = UIColor.white
            
        }
        
    }
}

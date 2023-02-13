//
//  UIButtonSetting.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/25.
//

import Foundation
import UIKit


extension UIButton {
    
    func detailImageTitleButtonOn(){
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.basicPurple.cgColor
        layer.cornerRadius = 15
        clipsToBounds = true
        titleLabel?.tintColor = .basicPurple
        
    }
    
    func detailImageTitleButtonOff(){
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.cornerRadius = 15
        clipsToBounds = true
        titleLabel?.tintColor = .systemGray2
        
    }

}


extension UIButton {
    
    func addMainBottomButton(imageName: String, borderColor: CGColor, title: String, titleColor: UIColor) {
            
        setImage(UIImage(named: "\(imageName).png"), for: .normal)
        layer.borderWidth = 2
        layer.borderColor = borderColor
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .white
        setTitle("\(title)", for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font =  .systemFont(ofSize: 15)
        self.alignTextBelow(spacing: 2.0)

    }
    
}

extension UIButton {
  
    func alignTextBelow(spacing: CGFloat) {
            guard let image = self.imageView?.image else {return}
            guard let titleLabel = self.titleLabel else {return}
            guard let titleText = titleLabel.text else {return}

            let titleSize = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font as Any])

            titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
        }
}

class BookmarkUIButton: UIButton {
    
    var data = Bookmark(id: "", title: "", address: "")
    
}


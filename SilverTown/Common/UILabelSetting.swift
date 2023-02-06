//
//  UILabelSetting.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/25.
//

import Foundation
import UIKit


class PaddingLabel: UILabel {

    var edgeInset: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}


extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))


        self.attributedText = attributedString
    }
}


extension PaddingLabel {
    
    func minMaxLabelInitLayout(){
        
        textColor = .basicRed
        layer.borderWidth = 1
        layer.borderColor = UIColor.basicRed.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
    
}

extension UILabel {
    
    func setfilterAddressSelected() {
        
        textColor = .basicRed
        layer.borderWidth = 1
        layer.borderColor = UIColor.basicRed.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
        sizeToFit()
    }
    
    func setfilterAddressUnSelected() {
        
        textColor = .systemGray2
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
        sizeToFit()
    }
    
    
    
}


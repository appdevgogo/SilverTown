//
//  UISettings.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/13.
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

extension UIViewController {
    
    func addBackButton(_ name: String) {
            
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .large)
        let imgObj = UIImage(systemName: name, withConfiguration: imgConfig)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        let btnBack = UIButton(frame: CGRect(x: -15, y: 0, width: 60, height: 45))
        btnBack.setImage(imgObj, for: .normal)
        btnBack.tintColor = .black
        btnBack.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        containerView.addSubview(btnBack)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
        navigationController?.navigationBar.barTintColor = .white

    }
    
    @objc func backAction(_ sender: UIButton) {
        
       navigationController?.popViewController(animated: true)
    }
    
    
}

extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
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

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//
//  UIViewControllerSetting.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/25.
//

import Foundation
import UIKit
import CoreData


extension UIViewController {
    
    func addRightNavigationButton(_ name: String) {
        
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let imgObj = UIImage(systemName: name, withConfiguration: imgConfig)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        let button = UIButton(frame: CGRect(x: -10, y: 0, width: 60, height: 45))
        button.setImage(imgObj, for: .normal)
        button.tintColor = .basicPurple
        button.addTarget(self, action: #selector(self.rightNavigationButtonAction(_:)), for: .touchUpInside)
        containerView.addSubview(button)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: containerView)
        
    }
    
    @objc func rightNavigationButtonAction(_ sender: UIButton) {
        
       print("clicked")
    }
    
}

extension UIViewController {
    
    func addBackButton(_ name: String, _ color: UIColor, _ tag: Int) {
            
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .large)
        let imgObj = UIImage(systemName: name, withConfiguration: imgConfig)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        let button = UIButton(frame: CGRect(x: -15, y: 0, width: 60, height: 45))
        button.tag = tag
        button.setImage(imgObj, for: .normal)
        button.tintColor = color
        button.addTarget(self, action: #selector(self.backButtonAction(_:)), for: .touchUpInside)
        containerView.addSubview(button)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
        navigationController?.navigationBar.barTintColor = .white

    }
    
    @objc func backButtonAction(_ sender: UIButton) {
        
        switch sender.tag {
            
        case 1:
            var context: NSManagedObjectContext!
            let coreDataManager = CoreDataManager(context: context)
            coreDataManager.saveData()
            
        default:
            break
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

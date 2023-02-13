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
    
    func addRightNavigationBookmarkButton(bookmark: Bookmark) {
        
        //여기서 우선적으로 CoreData에 북마크 데이터가 있는지 확인후에
        //만약에 있으면 하트Fill(tag=1) 없으면 하트NoFill(tag=0)
        
        let coreDataManager = CoreDataManager()
        let check = coreDataManager.getDataDetailBookmarkCheck(entityName: "BookmarkCoreData", id: "\(bookmark.id)")
        
        print(check)
        
        let name: String
        let tag: Int
        
        switch check {
            
        case 1:
            name = "heart.fill"
            tag = 1
            
        default:
            name = "heart"
            tag = 0
        }
        
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let imgObj = UIImage(systemName: name, withConfiguration: imgConfig)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        let button = BookmarkUIButton(frame: CGRect(x: -10, y: 0, width: 60, height: 45))
        
        button.data = bookmark
        button.tag = tag
        button.setImage(imgObj, for: .normal)
        button.tintColor = .basicPurple
        button.addTarget(self, action: #selector(self.rightNavigationBookmarkButtonAction(_:)), for: .touchUpInside)
        containerView.addSubview(button)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: containerView)
        
    }
    
    @objc func rightNavigationBookmarkButtonAction(_ sender: BookmarkUIButton) {
        
        print("clicked")
        print(sender.data.id)
        //tag=1(이미 북마크 존재)이면 클릭시 삭제
        //tag=0(북마크 없음)이면 클릭시 추가
        
        let name: String
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let coreDataManager = CoreDataManager()

        switch sender.tag {
            
        case 0:
            name = "heart.fill"
            sender.tag = 1
            
            
            let toSaveData =
            Bookmark(id: sender.data.id, title: sender.data.title, address: sender.data.address)

            coreDataManager.saveDataBookmark(bookmark: toSaveData)
            
        default:
            name = "heart"
            sender.tag = 0
            
            coreDataManager.deleteByIdData(entityName: "BookmarkCoreData", id: sender.data.id)
            
        }
        
        let imgObj = UIImage(systemName: name, withConfiguration: imgConfig)
        
        sender.setImage(imgObj, for: .normal)
        
    }
    
}

extension UIViewController {
    
    func addBackButton(_ name: String, _ color: UIColor) {
            
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .large)
        let imgObj = UIImage(systemName: name, withConfiguration: imgConfig)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        let button = UIButton(frame: CGRect(x: -15, y: 0, width: 60, height: 45))
        button.setImage(imgObj, for: .normal)
        button.tintColor = color
        button.addTarget(self, action: #selector(self.backButtonAction(_:)), for: .touchUpInside)
        containerView.addSubview(button)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
        navigationController?.navigationBar.barTintColor = .white

    }
    
    @objc func backButtonAction(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

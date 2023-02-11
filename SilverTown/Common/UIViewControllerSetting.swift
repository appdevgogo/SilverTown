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
        
        //여기서 우선적으로 CoreData에 북마크 데이터가 있는지 확인후에
        //만약에 있으면 하트Fill(tag=1) 없으면 하트NoFill(tag=0)
        
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
        //tag=1(이미 북마크 존재)이면 클릭시 삭제
        //tag=0(북마크 없음)이면 클릭시 추가
        let coreDataManager = CoreDataManager()
        let toSaveData =
            Bookmark(id: "st00002", title: "더클래식 500 실버타운", address: "서울특별시 광진구 능동로 90")

        coreDataManager.saveDataBookmark(bookmark: toSaveData)
        
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

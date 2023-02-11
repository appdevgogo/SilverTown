//
//  BookMarkViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/02/01.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CoreData

class BookmarkViewController: UIViewController {
    
    @IBOutlet weak var bookmarkTableView: UITableView!
    
    private var bookmarkViewModel = BookmarkViewModel()
    private var bookmarkArray = [Bookmark]()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        getBookmarkData()
        bindBookmarkTableView()
        
    }
    
    func initSetting(){
        
        addBackButton("arrow.backward", .black)

    }
    
    func getBookmarkData() {
        
        let coreDataManager = CoreDataManager()
        
        bookmarkArray = coreDataManager.getDataBookmark(entityName: "BookmarkCoreData")
        
    }
    
    func bookmarkReset() {
        
        let coreDataManager = CoreDataManager()
        let toSaveData = [
            Bookmark(id: "st00001", title: "SK그레이스힐(Grace Hill)", address: "서울시 강서구 양천로 470"),
            Bookmark(id: "st00003", title: "유당마을", address: "경기도 수원시 장안구 조원동 119-3번지"),
            Bookmark(id: "st00004", title: "하이원빌리지 실버타운", address: "서울특별시 용산구 한강로 2가 55번지"),
            Bookmark(id: "st00005", title: "더헤리티지 실버타운", address: "경기도 성남시 분당구 금곡동 305-2")]
        
        coreDataManager.deleteAllData(entityName: "BookmarkCoreData")
        
        for data in toSaveData{
            coreDataManager.saveDataBookmark(bookmark: data)
        }
        
        bookmarkArray = coreDataManager.getDataBookmark(entityName: "BookmarkCoreData")
        
        bookmarkViewModel.fetchItem(data: bookmarkArray)
        
    }
    
    func bindBookmarkTableView() {
        
        bookmarkViewModel.items.bind(
            to: bookmarkTableView.rx.items(
                cellIdentifier: "cell",
                cellType: BookmarkTableViewCell.self)
            
        ) { row, model, cell in
            
            cell.bookmarkTitleLabel.text = model.title
            cell.bookmarkAddressLabel.text = model.address
            
            cell.bookmarkDeleteButton.rx.tap.bind{
                
                let coreDataManager = CoreDataManager()
                
                coreDataManager.deleteByIdData(entityName: "BookmarkCoreData", id: model.id)
                
                self.bookmarkArray = coreDataManager.getDataBookmark(entityName: "BookmarkCoreData")
                
                self.bookmarkViewModel.fetchItem(data: self.bookmarkArray)
                
            }.disposed(by: cell.disposeBag)

        }.disposed(by: disposeBag)
        
        bookmarkViewModel.fetchItem(data: bookmarkArray)
    }

    @IBAction func bookmarkResetClick(_ sender: Any) {
        
        bookmarkReset()
        
    }
    
}



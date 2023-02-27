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
        bookmarkItemMove()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func initSetting(){
        
        addBackButton("arrow.backward", .black)
        
       // bookmarkTableView.dataSource = self
        bookmarkTableView.dragInteractionEnabled = true
        bookmarkTableView.dragDelegate = self
        bookmarkTableView.dropDelegate = self

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
        
        bookmarkTableView.rx.modelSelected(Bookmark.self).bind { element in
            
            let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "Detail")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }.disposed(by: disposeBag)
        
        bookmarkViewModel.fetchItem(data: bookmarkArray)
        
        
    }
    
    func bookmarkItemMove() {
        
        bookmarkTableView.rx.itemMoved
            .subscribe(onNext: { indexPaths in
                
                print(indexPaths.sourceIndex)
                print(indexPaths.destinationIndex)
                
             //   self.bookmarkArray.swapAt(<#T##i: Int##Int#>, <#T##j: Int##Int#>)
                
                let element = self.bookmarkArray.remove(at: indexPaths.sourceIndex.row)
                self.bookmarkArray.insert(element, at: indexPaths.destinationIndex.row)
                

         //       self.bookmarkArray.move(fromOffsets: IndexSet(integer: indexPaths.destinationIndex.row), toOffset: indexPaths.sourceIndex.row)
                                //indexPaths.destinationIndex.row //indexPaths.sourceIndex.row
                
                let coreDataManager = CoreDataManager()
                coreDataManager.deleteAllData(entityName: "BookmarkCoreData")
                
                for item in self.bookmarkArray{
                    
                    coreDataManager.saveDataBookmark(bookmark: item)
                    
                }
                
                print(self.bookmarkArray)
  
            })
            .disposed(by:disposeBag)
        
    }

    @IBAction func bookmarkResetClick(_ sender: Any) {
        
        bookmarkReset()
        
    }
    
}

//rxswift itemove로 하게되면 특정 디자인만 사용하게됨 그러므로 아래 사용 필요

extension BookmarkViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
            return [UIDragItem(itemProvider: NSItemProvider())]
        }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    //UITableViewDropDelegate를 실행하기 위해서는 필수임
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        print("performDropWith")
        
    }
    /*
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        //   let moveCell = self.list[sourceIndexPath.row]
        //  self.list.remove(at: sourceIndexPath.row)
        //   self.list.insert(moveCell, at: destinationIndexPath.row)
    }*/
}






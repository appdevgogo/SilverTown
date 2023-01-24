//
//  FilterViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class FilterViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
   // private var filterViewModel = FilterViewModel()
   // private var filterSubViewModel = FilterSubViewModel()
    //var ddbag = DisposeBag()
    
    let disposeBag = DisposeBag()
    var dataSource: RxTableViewSectionedReloadDataSource<MySection>!
    var sections = [
        MySection(header: "A", items: [1, 2, 3]),
        MySection(header: "B", items: [4, 5])
    ]
    private var subject: BehaviorRelay<[MySection]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dataSource 정의
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CostumTableViewCell
                cell.selectionStyle = .none
                cell.testLabel?.text = "Item \(item)"
                return cell
        })
        
        // 처음값 초기화
        subject.accept(sections)
        
        //섹션 문자
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        //오른쪽 인디케이터 문자
        dataSource.sectionIndexTitles = { ds in
            return ds.sectionModels.map { $0.header }
        }
        
        //오른쪽 인디케이터 문자와 인덱스참조가능
        dataSource.sectionForSectionIndexTitle = { ds, title, index in
            print(title)
            print(index)
            return ds.sectionModels.map { $0.header }.firstIndex(of: title) ?? 0
        }
        
        self.dataSource = dataSource
        
        // delegate 사용을 위한 선언
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        // binding
        subject
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        print("실행됨")/*
        sections.append(MySection(header: "C", items: [6, 7, 8]))
        sections.append(MySection(header: "D", items: [4, 5]))
        subject.accept(sections)*/
        
        
        sections[0].items = [7, 8]
        subject.accept(sections)
        
        
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource?[indexPath], dataSource?[indexPath.section] != nil else { return 0.0 }
        
        return CGFloat(40 + item * 10)
    }
}

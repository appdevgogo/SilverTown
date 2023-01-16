//
//  DetailViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/15.
//

import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initSetting(){
        
        addBackButton("arrow.backward")
    }
    
    
}

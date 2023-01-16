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
        print("test")
        
        testLabel.backgroundColor = .green
    }
    
}

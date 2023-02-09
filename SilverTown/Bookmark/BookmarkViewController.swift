//
//  BookMarkViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/02/01.
//

import UIKit
import CoreData

class BookmarkViewController: UIViewController {
    
    @IBOutlet weak var saveDataButton: UIButton!
    @IBOutlet weak var getDataButton: UIButton!
    
 //   private var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    
    
    @IBAction func saveDataButtonAction(_ sender: Any) {
        
      //  let test = CoreDataManager(context: context)
       // test.saveData()
        
    }
    
    @IBAction func getDataButtonAction(_ sender: Any) {
        
        //let test = CoreDataManager(context: context)
        //test.getData()
        
    }
    
    @IBAction func deleteAllButtonAction(_ sender: Any) {
        
       // let test = CoreDataManager(context: context)
       // test.deleteAllData(entityName: "FilterCoreData")
        
    }
    
    @IBAction func insertButtonAction(_ sender: Any) {
        
        //let test = CoreDataManager(context: context)
        //test.inesertData()
        
    }
    
    
}



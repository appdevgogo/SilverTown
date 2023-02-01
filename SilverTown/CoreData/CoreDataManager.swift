//
//  CoreDataManager.swift
//  SilverTown
//
//  Created by yyjweber on 2023/02/02.
//

import CoreData
import UIKit


class CoreDataManager {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext!) {
        self.context = context
        
        openData()
    }
    
    
    func openData(){
        
        context = appDelegate.persistentContainer.viewContext
    }
    
    
    func saveData() {
        
        let items = [0,1,2]
        
        print("Insert Array data..")
        
        for item in items {
            
            let dataObject = NSEntityDescription.insertNewObject(forEntityName: "PhoneBook", into: context)
            
            dataObject.setValue("\(item)", forKey: "memo")
            dataObject.setValue("Yoo", forKey: "personName")
            dataObject.setValue("010-3333-5555", forKey: "phoneNumber")
            
        }
                    
         do {
             try context.save()
             
         } catch {
             print("Insert data Failed")
             
         }

    }

    func getData() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PhoneBook")
        request.returnsObjectsAsFaults = false
        
        print("fetching data..")
        
        do {
            
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                print(data)

            }
        } catch {
            print("Fetching data Failed")
        }
    }
    
    func inesertData() {
        
        let dataObject = NSEntityDescription.insertNewObject(forEntityName: "PhoneBook", into: context)
        
        dataObject.setValue("memo111", forKey: "memo")
        dataObject.setValue("Yoo", forKey: "personName")
        dataObject.setValue("010-3333-4444", forKey: "phoneNumber")
        
        print("Insert data..")
        
         do {
             try context.save()
             
         } catch {
             print("Storing data Failed")
             
         }

    }
    
    func deleteAllData() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PhoneBook")
        request.returnsObjectsAsFaults = false
        
        print("deleting.. all data")
        
        do {
            
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                context.delete(data)

            }
        } catch {
            print("Delte All Data Failed")
        }
        
    }
    
    
}

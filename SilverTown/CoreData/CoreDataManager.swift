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
    
    init() {
      //  self.context = context
        
        openData()
    }
    
    func openData(){
        
        context = appDelegate.persistentContainer.viewContext
    }

    func getDataFilter(entityName : String) -> [Filter] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "\(entityName)")
        request.returnsObjectsAsFaults = false
        
        print("getDataFilter -->>")

        do {
            
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let decodedAddress = data.value(forKey: "address") as! String
                let decodedAddressSelected = data.value(forKey: "addressSelected") as! String
                let decodedDepositMin = data.value(forKey: "depositMin") as! Int
                let decodedDepositMax = data.value(forKey: "depositMax") as! Int
                let decodedMonthlyFeeMin = data.value(forKey: "monthlyFeeMin") as! Int
                let decodedMonthlyFeeMax = data.value(forKey: "monthlyFeeMax") as! Int
                let decodedUtilityCostMin = data.value(forKey: "utilityCostMin") as! Int
                let decodedUtilityCostMax = data.value(forKey: "utilityCostMax") as! Int

                
                let addressData = Data(decodedAddress.utf8)
                let arrayAddress = try! JSONDecoder().decode([String].self, from: addressData)
                
                let addressSelectedData = Data(decodedAddressSelected.utf8)
                let arrayAddressSelected = try! JSONDecoder().decode([String].self, from: addressSelectedData)
                
                
                let returnData = [Filter(address: arrayAddress, addressSelected: arrayAddressSelected, depositMin: decodedDepositMin, depositMax: decodedDepositMax, monthlyFeeMin: decodedMonthlyFeeMin, monthlyFeeMax: decodedMonthlyFeeMax, utilityCostMin: decodedUtilityCostMin, utilityCostMax: decodedUtilityCostMax)]
                
                
                return returnData

            }
            
        } catch {
            print("Fetching data Failed")
        }
        return []
    }
    
    func saveDataFilter(filter: Filter) {
        
        let dataObject = NSEntityDescription.insertNewObject(forEntityName: "FilterCoreData", into: context)
        
        guard let addressData = try? JSONEncoder().encode(filter.address),
        let encodedAddressString = String(data: addressData, encoding: .utf8) else { return }
        
        guard let addressSelectedData = try? JSONEncoder().encode(filter.addressSelected),
        let encodedAddressSelectedString = String(data: addressSelectedData, encoding: .utf8) else { return }
        
        dataObject.setValue(encodedAddressString, forKey: "address")
        dataObject.setValue(encodedAddressSelectedString, forKey: "addressSelected")
        dataObject.setValue(filter.depositMin, forKey: "depositMin")
        dataObject.setValue(filter.depositMax, forKey: "depositMax")
        dataObject.setValue(filter.monthlyFeeMin, forKey: "monthlyFeeMin")
        dataObject.setValue(filter.monthlyFeeMax, forKey: "monthlyFeeMax")
        dataObject.setValue(filter.utilityCostMin, forKey: "utilityCostMin")
        dataObject.setValue(filter.utilityCostMax, forKey: "utilityCostMax")
        
        do {
            try context.save()
            
        } catch {
            print("Insert data Failed")
            
        }
        
    }
    
    func saveDataSearch(search: Search) {
        
        let dataObject = NSEntityDescription.insertNewObject(forEntityName: "SearchCoreData", into: context)
        
        dataObject.setValue(search.title, forKey: "title")
        dataObject.setValue(search.address, forKey: "address")
        dataObject.setValue(search.deposit, forKey: "deposit")
        dataObject.setValue(search.monthlyFee, forKey: "monthlyFee")
        dataObject.setValue(search.utilityCost, forKey: "utilityCost")

        
        do {
            try context.save()
            
        } catch {
            print("Insert data Failed")
            
        }
        
    }
    
    func deleteAllData(entityName: String) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "\(entityName)")
        request.returnsObjectsAsFaults = false
        
        print("deleteAllData-->>")
        
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


/*
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

func getData(entityName : String) {
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "\(entityName)")
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
*/

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
    
    func deleteAllData(entityName: String) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "\(entityName)")
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
    
    
    func saveDataFilter(filter: Filter) {
        
        let dataObject = NSEntityDescription.insertNewObject(forEntityName: "FilterCoreData", into: context)
        
        guard let addressData = try? JSONEncoder().encode(filter.addresses),
        let encodedAddressString = String(data: addressData, encoding: .utf8) else { return }
        
        guard let addressSelectedData = try? JSONEncoder().encode(filter.addressesSelected),
        let encodedAddressSelectedString = String(data: addressSelectedData, encoding: .utf8) else { return }
        
        dataObject.setValue(encodedAddressString, forKey: "addresses")
        dataObject.setValue(encodedAddressSelectedString, forKey: "addressesSelected")
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
    /*
    func saveDataFilterMinMax(filter: [Int]) {
        
        let dataObject = NSEntityDescription.insertNewObject(forEntityName: "FilterCoreData", into: context)
        
        dataObject.setValue(filter[0], forKey: "depositMin")
        dataObject.setValue(filter[1], forKey: "depositMax")
        dataObject.setValue(filter[2], forKey: "monthlyFeeMin")
        dataObject.setValue(filter[3], forKey: "monthlyFeeMax")
        dataObject.setValue(filter[4], forKey: "utilityCostMin")
        dataObject.setValue(filter[5], forKey: "utilityCostMax")
        
        do {
            try context.save()
            
        } catch {
            print("Insert data Failed")
            
        }
        
    }*/
    
    func getDataFilter(entityName : String) -> [Filter] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "\(entityName)")
        request.returnsObjectsAsFaults = false
        
        print("fetching data..")

        do {
            
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let decodedAddresses = data.value(forKey: "addresses") as! String
                let decodedAddressesSelected = data.value(forKey: "addressesSelected") as! String
                let decodedDepositMin = data.value(forKey: "depositMin") as! Int
                let decodedDepositMax = data.value(forKey: "depositMax") as! Int
                let decodedMonthlyFeeMin = data.value(forKey: "monthlyFeeMin") as! Int
                let decodedMonthlyFeeMax = data.value(forKey: "monthlyFeeMax") as! Int
                let decodedUtilityCostMin = data.value(forKey: "utilityCostMin") as! Int
                let decodedUtilityCostMax = data.value(forKey: "utilityCostMax") as! Int

                
                let addressesData = Data(decodedAddresses.utf8)
                let arrayAddress = try! JSONDecoder().decode([String].self, from: addressesData)
                
                let addressesSelectedData = Data(decodedAddressesSelected.utf8)
                let arrayAddressSelected = try! JSONDecoder().decode([String].self, from: addressesSelectedData)
                
                
                let returnData = [Filter(addresses: arrayAddress, addressesSelected: arrayAddressSelected, depositMin: decodedDepositMin, depositMax: decodedDepositMax, monthlyFeeMin: decodedMonthlyFeeMin, monthlyFeeMax: decodedMonthlyFeeMax, utilityCostMin: decodedUtilityCostMin, utilityCostMax: decodedUtilityCostMax)]
                
                
                return returnData

            }
            
        } catch {
            print("Fetching data Failed")
        }
        return []
    }
    
    func getDataddressesSelected(entityName : String) -> [String] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "\(entityName)")
        request.returnsObjectsAsFaults = false
        
        print("fetching data..")

        do {
            
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let decodedAddressesSelected = data.value(forKey: "addressesSelected") as! String
                
                let addressesSelectedData = Data(decodedAddressesSelected.utf8)
                let arrayAddressSelected = try! JSONDecoder().decode([String].self, from: addressesSelectedData)
                
                
                let returnData = arrayAddressSelected
                
                
                return returnData

            }
            
        } catch {
            print("Fetching data Failed")
        }
        return []
    }
        
}

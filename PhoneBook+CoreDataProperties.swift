//
//  PhoneBook+CoreDataProperties.swift
//  
//
//  Created by yyjweber on 2023/02/01.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var memo: String?
    @NSManaged public var personName: String?
    @NSManaged public var phoneNumber: String?

}

//
//  Bookmark+CoreDataProperties.swift
//  
//
//  Created by yyjweber on 2023/02/01.
//
//

import Foundation
import CoreData


extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }

    @NSManaged public var time: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}

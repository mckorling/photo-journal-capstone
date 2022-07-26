//
//  Entry+CoreDataProperties.swift
//  photo-journal
//
//  Created by Megan Korling on 7/26/22.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var location: String?

}

extension Entry : Identifiable {

}

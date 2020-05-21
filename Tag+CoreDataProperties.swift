//
//  Tag+CoreDataProperties.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 20/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var title: String?
    @NSManaged public var tagOfEvent: Event?

}

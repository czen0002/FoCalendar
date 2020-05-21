//
//  Event+CoreDataProperties.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 20/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var alert: Int32
    @NSManaged public var isFocus: Bool
    @NSManaged public var title: String?
    @NSManaged public var notes: String?
    @NSManaged public var tag: Tag?
    @NSManaged public var color: Color?

}

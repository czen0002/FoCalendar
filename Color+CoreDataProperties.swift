//
//  Color+CoreDataProperties.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 20/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//
//

import Foundation
import CoreData


extension Color {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Color> {
        return NSFetchRequest<Color>(entityName: "Color")
    }

    @NSManaged public var title: String?
    @NSManaged public var rgb: String?
    @NSManaged public var colorOfEvent: Event?

}

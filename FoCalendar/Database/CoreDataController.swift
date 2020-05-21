//
//  CoreDataController.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 20/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: NSObject, DatabaseProtocol, NSFetchedResultsControllerDelegate {
    
    var listeners = MulticastDelegate<DatabaseListener>()
    var persistentContainer: NSPersistentContainer
    
    // Fetched Results Controller
    var allEventsFetchedResultsController: NSFetchedResultsController<Event>?
    var allColorsFetchedResultsController: NSFetchedResultsController<Color>?
    var allTagsFetchedResultsController: NSFetchedResultsController<Tag>?
    
    override init() {
        // Load the Core Data Stack
        persistentContainer = NSPersistentContainer(name: "FoCalendar")
        
         persistentContainer.loadPersistentStores() {
            (description, error) in
               if let error = error {
                   fatalError("Failed to load Core Data stack: \(error)")
               }
        }
        
        super.init()
        
        if fetchAllEvents().count == 0 {
            createDefaultEvents()
        }
        
        if fetchAllColors().count == 0 {
            createDefaultColors()
        }
        
        if fetchAllTags().count == 0 {
            createDefaultTags()
        }
    }
    
    
    func saveContext () {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                fatalError("Failed to save to CoreData: \(error)")
            }
        }
    }
    
    
    // MARK: - Database Protocol Functions
    
    func cleanup() {
        saveContext()
    }
    
    // Create a event in persistentContainer viewContext
    func createEvent(title: String, startDate: Date, endDate: Date, isFocus: Bool, alert: Int32?, notes: String?) -> Event {
        let event = NSEntityDescription.insertNewObject(forEntityName: "Event",
        into: persistentContainer.viewContext) as! Event
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.isFocus = isFocus
        event.alert = alert ?? -1
        event.notes = notes
        self.saveContext()
        return event
    }
    
    // Delete a event from persistentContainer viewContext
    func deleteEvent(event: Event) {
        persistentContainer.viewContext.delete(event)
        self.saveContext()
    }
    
    // Create a color in persistentContainer viewContext
    func createColor(title: String, rgb: String) -> Color {
        let color = NSEntityDescription.insertNewObject(forEntityName: "Color",
        into: persistentContainer.viewContext) as! Color
        
        color.title = title
        color.rgb = rgb
        self.saveContext()
        return color
    }
    
    // Delete a color from persistentContainer viewContext
    func deleteColor(color: Color) {
        persistentContainer.viewContext.delete(color)
        self.saveContext()
    }
    
    // Create a tag in persistentContainer viewContext
    func createTag(title: String) -> Tag {
        let tag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: persistentContainer.viewContext) as! Tag
        
        tag.title = title
        self.saveContext()
        return tag
    }
    
    // Delete a tag from persistentContainer viewContext
    func deleteTag(tag: Tag) {
        persistentContainer.viewContext.delete(tag)
        self.saveContext()
    }
    
    // Update the color of a event
    func updateColorOfEvent(color: Color, event: Event) -> Bool {
        event.color = color
        return true
    }
    
    func updateTagOfEvent(tag: Tag, event: Event) -> Bool {
        event.tag = tag
        return true
    }
    
    func removeColorFromEvent(color: Color, event: Event) {
        event.color = nil
    }
    
    func removeTagFromEvent(tag: Tag, event: Event) {
        event.tag = nil
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        if listener.listenerType == .events || listener.listenerType == .all {
            listener.onEventChange(change: .update, events: fetchAllEvents())
        }
        
        if listener.listenerType == .colors || listener.listenerType == .all {
            listener.onColorChange(change: .update, colors: fetchAllColors())
        }
        
        if listener.listenerType == .tags || listener.listenerType == .all {
            listener.onTagChange(change: .update, tags: fetchAllTags())
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
    
    // MARK: - Core Data Fetch Requests
    
    // Fetch all events from persistentContainer viewContext
    func fetchAllEvents() -> [Event] {
        // If results controller not currently initialized
        if allEventsFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
            // Sort by startDate
            let startDateSortDescriptor = NSSortDescriptor(key: "startDate", ascending: true)
            fetchRequest.sortDescriptors = [startDateSortDescriptor]
            // Initialize Results Controller
            allEventsFetchedResultsController = NSFetchedResultsController<Event> (fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            // Set this class to be the results delegate
            allEventsFetchedResultsController?.delegate = self
            
            do {
                try allEventsFetchedResultsController?.performFetch()
            } catch {
                print("Fetch Request Failed: \(error)")
            }
        }
        
        var events = [Event]()
        if allEventsFetchedResultsController?.fetchedObjects != nil {
            events = (allEventsFetchedResultsController?.fetchedObjects)!
        }
        return events
    }
    
    // Fetch all colors from persistentContainer viewContext
    func fetchAllColors() -> [Color]{
        // If results controller not currently initialized
        if allColorsFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Color> = Color.fetchRequest()
            // Sort by name
            let nameSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            // Initialize Results Controller
            allColorsFetchedResultsController = NSFetchedResultsController<Color> (fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            // Set this class to be the results delegate
            allColorsFetchedResultsController?.delegate = self
            
            do {
                try allColorsFetchedResultsController?.performFetch()
            } catch {
                print("Fetch Request Failed: \(error)")
            }
        }
        
        var colors = [Color]()
        if allColorsFetchedResultsController?.fetchedObjects != nil {
            colors = (allColorsFetchedResultsController?.fetchedObjects)!
        }
        return colors
    }
    
    // Fetch all tags from persistentContainer viewContext
    func fetchAllTags() -> [Tag]{
        // If results controller not currently initialized
        if allTagsFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
            // Sort by name
            let nameSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            // Initialize Results Controller
            allTagsFetchedResultsController = NSFetchedResultsController<Tag> (fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            // Set this class to be the results delegate
            allTagsFetchedResultsController?.delegate = self
            
            do {
                try allTagsFetchedResultsController?.performFetch()
            } catch {
                print("Fetch Request Failed: \(error)")
            }
        }
        
        var tags = [Tag]()
        if allTagsFetchedResultsController?.fetchedObjects != nil {
            tags = (allTagsFetchedResultsController?.fetchedObjects)!
        }
        return tags
    }
    
    
    // MARK: - Create Default Data
    
    func createDefaultEvents() {
        print("createDefaultEvents")
        let isoStartDate = "2020-05-20T10:44:00+0000"
        let isoEndDate = "2020-05-21T21:30:00+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let startDate = dateFormatter.date(from:isoStartDate)!
        let endDate = dateFormatter.date(from:isoEndDate)!
        
        
        let _ = createEvent(title: "Event1", startDate: startDate, endDate: endDate, isFocus: true, alert: 0, notes: "Event1 notes")
//        let _ = createEvent(title: <#T##String#>, startDate: <#T##Date#>, endDate: <#T##Date#>, isFocus: <#T##Bool#>, alert: <#T##Int32?#>, notes: <#T##String?#>)
    }
    
    func createDefaultColors() {
        print("createDefaultColors")
        let _ = createColor(title: "Yellow", rgb: "FFFF00")
        let _ = createColor(title: "Red", rgb: "FF0000")
        let _ = createColor(title: "Blue", rgb: "0000FF")
        let _ = createColor(title: "Gray", rgb: "808080")
        let _ = createColor(title: "Purple", rgb: "7F00FF")
        let _ = createColor(title: "Green", rgb: "006633")
        let _ = createColor(title: "Orange", rgb: "FF8000")
    }
    
    func createDefaultTags() {
        print("createDefaultTags")
        let _ = createTag(title: "Study")
        let _ = createTag(title: "Read")
        let _ = createTag(title: "Sport")
        let _ = createTag(title: "Entertainment")
        let _ = createTag(title: "Social")
        let _ = createTag(title: "Work")
        let _ = createTag(title: "Other")
    }
}

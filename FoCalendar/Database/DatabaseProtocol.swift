//
//  DatabaseProtocol.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 20/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import Foundation

// Define tha type of change occurred to the database
enum DatabaseChange {
    case add
    case remove
    case update
}

// List different types of listenter, determine what changes the listener cares about
enum ListenerType {
    case events
    case colors
    case tags
    case all
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onEventChange(change: DatabaseChange, events: [Event])
    func onColorChange(change: DatabaseChange, colors: [Color])
    func onTagChange(change: DatabaseChange, tags: [Tag])
}

protocol DatabaseProtocol: AnyObject {
    func cleanup()
    // Event
    func createEvent(title: String, startDate: Date, endDate: Date, isFocus: Bool, alert: Int32?, notes: String?) -> Event
    func deleteEvent(event: Event)
    
    // Color
    func createColor(title: String, rgb: String) -> Color
    func deleteColor(color: Color)
    
    // Tag
    func createTag(title: String) -> Tag
    func deleteTag(tag: Tag)
    
    func updateColorOfEvent(color: Color, event: Event) -> Bool
    
    func updateTagOfEvent(tag: Tag, event: Event) -> Bool
    
    func removeColorFromEvent(color: Color, event: Event)
    
    func removeTagFromEvent(tag: Tag, event: Event)
    
    // Listener
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
//    // Cocktail Draft in Child Context
//    func createCocktailDraft(indexPath: IndexPath) -> Cocktail
//    func createNewCocktailDraft() -> Cocktail
//    func discardDraft()
//    func didFinish()
}

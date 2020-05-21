//
//  EventsTableViewController.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 19/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController, DatabaseListener {
    
    var allEvents: [Event] = []
    var array: [String] = ["AA","BB","CC"]
    
    var event: Event?
    
    weak var databaseController: DatabaseProtocol?
    var listenerType: ListenerType = .events

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.tabBarController?.tabBar.isTranslucent = false
        databaseController?.addListener(listener: self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    
    // MARK: - Database Listener
    
    func onEventChange(change: DatabaseChange, events: [Event]) {
        allEvents = events
    }
    
    func onColorChange(change: DatabaseChange, colors: [Color]) {
        // Do nothing not called
    }
    
    func onTagChange(change: DatabaseChange, tags: [Tag]) {
        // Do nothing not called
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell

        let event = allEvents[indexPath.row]
        cell.eventTitleLabel?.text = event.title
        
        let dfStartDate = DateFormatter()
        let dfEndDate = DateFormatter()
        dfStartDate.dateFormat = "yyyy-MM-dd hh:mm"
        dfEndDate.dateFormat = "hh:mm"
        let startDate = dfStartDate.string(from: event.startDate!)
        let endDate = dfEndDate.string(from: event.endDate!)
        
        cell.eventDateLabel?.text = "\(startDate) - \(endDate)"
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "eventDetailSegue", let cell = sender as? UITableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                let destination = segue.destination as! EventDetailTableViewController
                destination.event = allEvents[indexPath.row]
            }
        }
    }
    

}

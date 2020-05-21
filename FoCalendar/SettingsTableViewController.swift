//
//  SettingsTableViewController.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 17/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    var day: Int = 1
    var startTime: Int = 1
    var endTime: Int = 1
    var length: Int = 10
    
    var daysArray: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var startTimesArray: [String] = ["Midnight", "1:00 am", "2:00 am", "3:00 am", "4:00 am", "5:00 am", "6:00 am", "7:00 am", "8:00 am", "9:00 am", "10:00 am", "11:00 am", "Noon" ]
    var endTimesArray: [String] = ["Noon", "1:00 pm", "2:00 pm", "3:00 pm", "4:00 pm", "5:00 pm", "6:00 pm", "7:00 pm", "8:00 pm", "9:00 pm", "10:00 pm", "11:00 pm", "Midnight"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "signCell")
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "weekStartsCell")
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayStartsCell")
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayEndsCell")
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "focusLengthCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.tabBarController?.tabBar.isTranslucent = false
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "signInSegue", sender: indexPath.row)

        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                performSegue(withIdentifier: "weekStartsSegue", sender: indexPath.row)
            } else if indexPath.row == 1 {
                performSegue(withIdentifier: "dayStartsSegue", sender: indexPath.row)
            } else {
                performSegue(withIdentifier: "dayEndsSegue", sender: indexPath.row)
            }

        } else {
            performSegue(withIdentifier: "focusLengthSegue", sender: indexPath.row)
        }

    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "signCell", for: indexPath)
            let cell = UITableViewCell(style: .default, reuseIdentifier: "signCell")
            cell.textLabel?.text = "Sign In or Sign Up"
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }

        if indexPath.section == 1 {
            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "weekStartsCell", for: indexPath)
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "weekStartsCell")
                
                cell.textLabel?.text = "Week starts"
                cell.detailTextLabel?.text = "\(daysArray[day])"
                cell.accessoryType = .disclosureIndicator
                
                return cell
            } else if indexPath.row == 1 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "dayStartsCell", for: indexPath)
                let cell = UITableViewCell(style: .value1, reuseIdentifier: "dayStartsCell")
                
                cell.textLabel?.text = "Day starts at"
                cell.detailTextLabel?.text = "\(startTimesArray[startTime])"
                cell.accessoryType = .disclosureIndicator
                
                return cell
            }

//            let cell = tableView.dequeueReusableCell(withIdentifier: "dayEndsCell", for: indexPath)
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "dayEndsCell")
            
            cell.textLabel?.text = "Day ends at"
            cell.detailTextLabel?.text = "\(endTimesArray[endTime])"
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }

//        let cell = tableView.dequeueReusableCell(withIdentifier: "focusLengthCell", for: indexPath)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "focusLengthCell")
        

        cell.textLabel?.text = "Focus Length"
        cell.detailTextLabel?.text = "\((length*5)+10) minutes"
        cell.accessoryType = .disclosureIndicator

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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weekStartsSegue" {
            let destination = segue.destination as! WeekStartsTableViewController
            destination.day = day
        } else if segue.identifier == "dayStartsSegue" {
            let destination = segue.destination as! DayStartsTableViewController
            destination.startTime = startTime
        } else if segue.identifier == "dayEndsSegue" {
            let destination = segue.destination as! DayEndsTableViewController
            destination.endTime = endTime
        } else if segue.identifier == "focusLengthSegue" {
            let destination = segue.destination as! FocusLengthViewController
            destination.index = length
        }
    }
    

}

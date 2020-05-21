//
//  ReportViewController.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 17/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    @IBOutlet weak var focusSummaryView: UIView!
    @IBOutlet weak var distributionSummaryView: UIView!
    
    @IBOutlet weak var focusChartView: UIView!
    @IBOutlet weak var eventsChartView: UIView!
    
    @IBOutlet weak var viewSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.focusSummaryView.alpha = 1.0
        self.distributionSummaryView.alpha = 0.0
        
        self.focusChartView.alpha = 1.0
        self.eventsChartView.alpha = 0.0
        viewSegment.selectedSegmentIndex = 0
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.tabBarController?.tabBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //viewSegment.selectedSegmentIndex = 0
    }
    

    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
//            UIView.animate(withDuration: 0.5, animations: {
//                self.focusSummaryView.alpha = 1.0
//                self.distributionSummaryView.alpha = 0.0
//            })
            self.focusSummaryView.alpha = 1.0
            self.distributionSummaryView.alpha = 0.0
            
            self.focusChartView.alpha = 1.0
            self.eventsChartView.alpha = 0.0
            break
        case 1:
//            UIView.animate(withDuration: 0.5, animations: {
//                self.focusSummaryView.alpha = 0.0
//                self.distributionSummaryView.alpha = 1.0
//            })
            self.focusSummaryView.alpha = 0.0
            self.distributionSummaryView.alpha = 1.0
            
            self.focusChartView.alpha = 0.0
            self.eventsChartView.alpha = 1.0
            break
        default:
            break
        }
    }
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

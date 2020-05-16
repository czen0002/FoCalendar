//
//  FocusLengthViewController.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 16/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class FocusLengthViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var focusLengthButton: UIButton!
    @IBOutlet weak var timePicker: UIPickerView!
    
    var timeLength: Int?
    var allTimeLength: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeButton()
        
        self.generatePickerData()
        
        // Connect picker data
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
        
        // Default picker data
        timePicker.selectRow(0, inComponent: 0, animated: true)
        timeLength = allTimeLength[0]
    }
    
    
    // MARK: - Customize UI
    func customizeButton() {
        focusLengthButton.layer.cornerRadius = 7
    }
    
    
    // MARK: - UIPicker Delegate
    
    // The number of components in UIPickerView is 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows in UIPickerView is the number of time length
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allTimeLength.count

    }
    
    // Display time length for each of row in UIPickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(allTimeLength[row]) minutes"

    }
    
    // UIPickerView return integer when its corresponding row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Not allow to select a row if no ingredient

        timeLength = allTimeLength[row]
    }
    
    func generatePickerData() {
        var length = 10
        while length <= 180 {
            self.allTimeLength.append(length)
            length += 5
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

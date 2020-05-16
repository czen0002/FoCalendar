//
//  ResetPasswordViewController.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 16/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customizeTextField()
        self.customizeButton()
        emailTextField.text = nil
        emailTextField.placeholder = "Email address"
    }
    
    
    // MARK: - Customize UI
    
    func customizeTextField() {
        // Create the bottom line
        let bottomLine1 = CALayer()
        
        bottomLine1.frame = CGRect(x: 0, y: emailTextField.frame.height - 2, width: emailTextField.frame.width, height: 2)
        bottomLine1.backgroundColor = UIColor.systemGray.cgColor
        
        emailTextField.borderStyle = .none
        
        emailTextField.layer.addSublayer(bottomLine1)
        
    }
    
    func customizeButton() {
        resetPasswordButton.layer.cornerRadius = 7
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

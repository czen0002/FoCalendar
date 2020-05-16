//
//  SignUpViewController.swift
//  FoCalendar
//
//  Created by CHENG ZENG on 16/5/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customizeTextField()
        self.customizeButton()
        
        emailTextField.text = nil
        emailTextField.placeholder = "Email address"
        
        passwordTextField.text = nil
        passwordTextField.placeholder = "Password"
    }
    
    // MARK: - Customize UI
    
    func customizeTextField() {
        // Create the bottom line
        let bottomLine1 = CALayer()
        
        bottomLine1.frame = CGRect(x: 0, y: emailTextField.frame.height - 2, width: emailTextField.frame.width, height: 2)
        bottomLine1.backgroundColor = UIColor.systemGray.cgColor
        emailTextField.borderStyle = .none
        emailTextField.layer.addSublayer(bottomLine1)
        
        let bottomLine2 = CALayer()
        
        bottomLine2.frame = CGRect(x: 0, y: passwordTextField.frame.height - 2, width: passwordTextField.frame.width, height: 2)
        bottomLine2.backgroundColor = UIColor.systemGray.cgColor
        passwordTextField.borderStyle = .none
        passwordTextField.layer.addSublayer(bottomLine2)
    }
    
    func customizeButton() {
        signUpButton.layer.cornerRadius = 7
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.systemBlue.cgColor
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

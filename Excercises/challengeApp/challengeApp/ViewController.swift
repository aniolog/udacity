//
//  ViewController.swift
//  challengeApp
//
//  Created by Gustavo on 8/8/17.
//  Copyright © 2017 Anibal. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var lockableSwitch: UISwitch!
    
    @IBOutlet weak var lockableTextField: UITextField!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet weak var cashTextField: UITextField!
    
    let zipCodeDelegate = ZipCodeTextFieldDelegate()
    let cashDelegate = CashTextFieldDelegate()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zipCodeTextField.delegate =  zipCodeDelegate
        cashTextField.delegate = cashDelegate
        lockableTextField.delegate = self
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return lockableSwitch.isOn
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    @IBAction func switchChanged(_ sender: Any) {
        
        if (lockableSwitch.isOn){
            lockableTextField.resignFirstResponder()
        }
        
    }

}


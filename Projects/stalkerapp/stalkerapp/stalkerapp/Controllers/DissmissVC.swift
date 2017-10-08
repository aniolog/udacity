//
//  DissmissVC.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class DissmissVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        // Do any additional setup after loading the view.
    }

    
    @IBAction func dismissPopup(_ sender: Any) {
    
    }
    
    @IBAction func dismissButtonPresed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        return true
    }
    
    
}

//
//  DissmissVC.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var stalk: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        stalk.isEnabled = false
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func dismissPopup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonPresed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let value = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if value.characters.count > 0 {
            stalk.isEnabled = true
        } else {
            stalk.isEnabled = false
        }
        return true;
    }
    
    
    @IBAction func performStalk(_ sender: Any) {
        
        Client.shared.loadData(email: email.text!){
            (person,socialMedias) in
            DispatchQueue.main.async {
                do{
                    if(person != nil){
                        try LocalDB.shared.stack?.context.save()
                        self.dismiss(animated: true, completion: nil)
                    }
                }catch{
                    fatalError("unable to save")
                }
            }
        }
        
        
        
    }
    
    
    
}

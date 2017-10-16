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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        stalk.isEnabled = false
        indicator.isHidden = true
        
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
        prepareIndicator(isHidden: false)
        Client.shared.loadData(email: email.text!){
            (person,socialMedias,status) in
            DispatchQueue.main.async {
                self.prepareIndicator(isHidden: true)
                do{
                    if(person != nil){
                        print(status)
                        try LocalDB.shared.stack?.context.save()
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        var errorMessage:String
                        if(status<0){
                            errorMessage = "There is no internet"
                        }else{
                            errorMessage = "Unable to find that person"
                        }
                        self.displayError(title: "Error", message: errorMessage, dismissMessage: "Got it"){
                            () in
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }catch{
                    fatalError("unable to save")
                }
            }
        }
        
    }
    
    func prepareIndicator(isHidden:Bool){
        indicator.isHidden = isHidden
        if(isHidden){
            indicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }else{
            indicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    
    
}

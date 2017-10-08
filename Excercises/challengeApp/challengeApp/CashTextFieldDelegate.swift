//
//  CashTextFieldDelegate.swift
//  challengeApp
//
//  Created by Gustavo on 8/8/17.
//  Copyright © 2017 Anibal. All rights reserved.
//

import Foundation
import UIKit


class CashTextFieldDelegate : NSObject, UITextFieldDelegate {


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newValue = textField.text! as NSString
        newValue = newValue.replacingCharacters(in: range, with: string) as NSString
        var newValueString = String(newValue)
        
        let digits = CharacterSet.decimalDigits
        var digitsString = ""
        for digit in (newValueString.unicodeScalars){
            if digits.contains(UnicodeScalar(digit.value)!){
                digitsString.append("\(digit)")
            }
        }
        
        
        if let numOfPennies = Int(digitsString) {
            newValue = "$" + self.dollarStringFromInt(numOfPennies) + "." + self.centsStringFromInt(numOfPennies) as NSString
        } else {
            newValue = "$0.00"
        }
        
        textField.text = newValue as String
        
        return false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)!{
                textField.text = "$ 0.00"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)!{
            textField.text = "$ 0.00"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }

    
    func dollarStringFromInt(_ value: Int) -> String {
        return String(value / 100)
    }
    
    func centsStringFromInt(_ value: Int) -> String {
        
        let cents = value % 100
        var centsString = String(cents)
        
        if cents < 10 {
            centsString = "0" + centsString
        }
        
        return centsString
    }

}

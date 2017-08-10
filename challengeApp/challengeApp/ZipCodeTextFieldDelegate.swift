//
//  ZipCodeTextFieldDelegate.swift
//  challengeApp
//
//  Created by Gustavo on 8/8/17.
//  Copyright © 2017 Anibal. All rights reserved.
//

import Foundation
import UIKit


class ZipCodeTextFieldDelegate : NSObject, UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newValue = textField.text! as NSString
        newValue = newValue.replacingCharacters(in: range, with: string) as NSString
        return newValue.length<=5;
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}

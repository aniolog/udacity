//
//  DesignableView.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {

    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
        
    }
    
    
    
}

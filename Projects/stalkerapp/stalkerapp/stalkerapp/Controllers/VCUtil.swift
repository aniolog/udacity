//
//  VCUtil.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/15/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func prepareActivityIndicator()-> UIActivityIndicatorView{
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        return activityIndicator
    }
    
    func displayError(title:String, message:String, dismissMessage:String, handler:@escaping ()->Void){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissMessage, style: .default){ action in
            alert.dismiss(animated: true, completion: nil)
            handler()
        }
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func roundedImage(from: UIImage, radius: CGFloat) -> UIImage {
        let imageView: UIImageView = UIImageView(image: from)
        var layer: CALayer = CALayer()
        layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
    
}

//
//  AddresVCViewController.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/15/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit
import MapKit

class AddresVC: UIViewController {

    var person:Person?
    var activityIndicator: UIActivityIndicatorView?
    var geocoder: CLGeocoder?
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(person?.address);
        activityIndicator = prepareActivityIndicator()
        activityIndicator?.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        geocoder = CLGeocoder()
        geocoder?.geocodeAddressString((person?.address)!) {
            placeMarks, error in
            
            UIApplication.shared.endIgnoringInteractionEvents()
            self.activityIndicator?.stopAnimating()
            if error != nil{
                self.displayError(title: "Error", message: "the app failed to locate that address", dismissMessage:"Got it"){
                    () in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                if let placeMark = placeMarks?[0], (placeMarks?.count)!>0{
                    let personCoordinate = CLLocationCoordinate2D(latitude: (placeMark.location?.coordinate.latitude)!, longitude: (placeMark.location?.coordinate.longitude)!)
                    let annotation:StalkerPin = StalkerPin(coordinate: personCoordinate, title: (self.person?.fullName)!, subtitle: (self.person?.address)!)
                    self.map.addAnnotation(annotation)
                    self.map.showAnnotations(self.map.annotations, animated: true)
                }
            }
        }
    }


}

//
//  DetailViewController.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var person:Person?
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = person?.fullName
        
        
        guard let ageText:String = person?.age! else {
            return
        }
        
        guard let ageRangeText: String = person?.ageRange else {
            return
        }
        
        self.age.text = "Age: \(ageText) (\(ageRangeText))"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

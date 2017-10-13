//
//  DetailViewController.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit
import CoreData
class DetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var person:Person?
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>?
    
    var socialMedias:[SocialMedia] = [SocialMedia]()
    
    
    @IBOutlet weak var socialMediasTable: UITableView!
    
    @IBOutlet weak var personAvatar: UIImageView!
    
    @IBOutlet weak var age: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socialMediasTable.dataSource = self
        socialMediasTable.delegate = self
        self.navigationItem.title = person?.fullName
        guard let ageText:String = person?.age! else {
            return
        }
        guard let ageRangeText: String = person?.ageRange else {
            return
        }
        self.age.text = "Age: \(ageText) (\(ageRangeText))"
     
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SocialMedia")
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "person = %@", argumentArray: [person!])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: (LocalDB.shared.stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            socialMedias  = try (fetchedResultsController?.managedObjectContext.fetch(request)) as! [SocialMedia]
            print(socialMedias.count)
            socialMediasTable.reloadData()
        }catch{
            fatalError("unable to fetch social medias")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let socialMedia = socialMedias[indexPath.row]
        print(socialMedia.typeName)
        cell.textLabel?.text = socialMedia.typeName
        cell.detailTextLabel?.text = socialMedia.username
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(socialMedias.count)
        return socialMedias.count
    }
    
}

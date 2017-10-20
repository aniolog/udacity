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
        let image = UIImage(data: (person?.photo)!)
        personAvatar.image = roundedImage(from: image!, radius: 65)
        
        let rightButton = UIButton.init(type: .custom)
        rightButton.setTitle("Menu", for: .normal)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.addTarget(self, action: #selector(self.openMenu), for: UIControlEvents.touchUpInside)
        rightButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        rightButton.imageView?.contentMode = .scaleAspectFit
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.title = person?.fullName
        
        if(person?.age != nil){
            guard let ageText:String = person?.age! else {
                return
            }
            guard let ageRangeText: String = person?.ageRange else {
                return
            }
            self.age.text = "Age: \(ageText) (\(ageRangeText))"
        }else{
            self.age.text = ""
        }
      
        
     
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SocialMediaTableViewCell
        let socialMedia = socialMedias[indexPath.row]
        cell.title.text = socialMedia.typeName
        guard let username = socialMedia.username else{
            cell.username.text = "@"
            return cell
        }
        let nameImage:String = socialMedia.typeName!.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        cell.logo.image = UIImage(named: nameImage.lowercased())
        cell.username.text = "@\(username)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialMedias.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let socialMediaUrl = socialMedias[indexPath.row].url
        let url = URL(string: socialMediaUrl!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    @objc func openMenu()  {
        let menuController = UIAlertController(title:nil, message:nil, preferredStyle: .actionSheet)
        
        
        guard let fullname = person!.fullName else{
           
            return
        }
        
        if (person?.address != nil){
            let addressButton = UIAlertAction(title: "Check \(fullname)'s address", style: .default, handler: { (action) -> Void in
                let addressVC =  self.storyboard?.instantiateViewController(withIdentifier:  "address") as! AddresVC
                addressVC.person = self.person
                self.navigationController?.pushViewController(addressVC, animated: true)
            })
            menuController.addAction(addressButton)
        }
      
        let deleteButton = UIAlertAction(title: "Delete \(fullname) from the history", style: .destructive, handler: { (action) -> Void in
            LocalDB.shared.stack?.context.delete(self.person!)
            self.navigationController?.popViewController(animated: true)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Delete button tapped")
        })
        menuController.addAction(deleteButton)
        menuController.addAction(cancelButton)
        self.present(menuController, animated: true, completion: nil)
        
        
    }
    
}

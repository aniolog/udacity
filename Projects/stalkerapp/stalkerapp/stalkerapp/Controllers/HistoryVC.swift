//
//  ViewController.swift
//  stalkerapp
//
//  Created by Carlos Lozano on 10/8/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import UIKit
import CoreData
class HistoryVC: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fr.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (LocalDB.shared.stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func preparePhoto(cell: StalkedTableViewCell,photoData:Data){
            let image = UIImage(data: photoData)
            cell.photo.image = self.roundedImage(from: image!, radius: 60)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! StalkedTableViewCell
        let person = fetchedResultsController?.object(at: indexPath) as! Person
        cell.name.text = person.fullName
        cell.email.text = person.email
        if (person.photo != nil ){
            preparePhoto(cell: cell,photoData: person.photo!)
        }else{
            Client.shared.getPhotoData(person: person){
                () in
                preparePhoto(cell: cell,photoData: person.photo!)
            }
        }
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailVC
        detailVC.person = fetchedResultsController?.object(at: indexPath) as! Person
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
}


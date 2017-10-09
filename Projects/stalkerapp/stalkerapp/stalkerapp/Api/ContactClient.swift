//
//  Client.swift
//  VirtualTourist
//
//  Created by Gustavo on 9/26/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class Client {
    
    private init(){}
    
    static let shared = Client()
    
    
    
    func loadData(email:String , handler:@escaping (Person?,[SocialMedia]?)->Void){
        
        let parameters: [String: AnyObject] = [
            Client.ParameterKeys.Email: email as AnyObject,
            Client.ParameterKeys.Style: Client.FlickrParameterValues.Style as AnyObject,
            ]
        
        
        
        let session = URLSession.shared
        let request = URLRequest(url: prepareParameters(parameters))
        
        let task = session.dataTask(with: request){
            (data,response,error) in
            
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode>=200 && statusCode<299 else{
                print("there is an error in your request")
                handler(nil,nil)
                return
            }
            
            if error != nil {
                return
            }
            
            do {
                let responseData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                let person = Person(email: email, context: (LocalDB.shared.stack?.context)!)
                let demographics = responseData!["demographics"] as! [String:AnyObject]
                let contactInfo = responseData!["contactInfo"] as! [String:AnyObject]
                let socialProfiles = responseData!["socialProfiles"] as! [String:AnyObject]
                
                
                person.age = demographics["age"] as! String
                person.gender = demographics["gender"] as! String
                person.ageRange = (demographics["ageRange"] as! String)
                person.fullName = contactInfo["fullName"] as! String
                
                var socialMedias = [SocialMedia]()
                
                
                for (key, value) in socialProfiles {
                    
                    let socialMediaArray = value as! [[String:AnyObject]]
                    for (socialMediaDict) in socialMediaArray{
                    
                        print(socialMediaDict)
                        
                        let typeName = socialMediaDict["typeName"]
                        let url = socialMediaDict["url"]
                        var username = ""
                        if let usernameTest = socialMediaDict["username"] {
                            username = usernameTest as! String
                        }else{
                            username = socialMediaDict["userid"]! as! String
                        }
                        var socialMediaObj = SocialMedia(typeName: typeName! as! String, url: url! as! String, username: url! as! String, context: (LocalDB.shared.stack?.context)!)
                        socialMediaObj.person = person
                        socialMedias.append(socialMediaObj)
                        
                    }
                  
                }
            
                handler(person,socialMedias)
                
            }catch{
                print( "error parsing response")
            }
            
            
            
            
        }
        task.resume()
        
        
        
    }
    
    
    
    
    
    
    private func prepareParameters(_ parameters: [String: AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Client.FullContact.APIScheme
        components.host = Client.FullContact.APIHost
        components.path = Client.FullContact.APIPath
        components.port = Client.FullContact.APIPort
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        print(components.url)
        return components.url!
    }
    
}


extension Client {
    struct FullContact {
        static let APIScheme = "http"
        static let APIHost = "gopayonline.co"
        static let APIPath = "/contact/contact.json"
        static let APIPort = 8088
        
    }
    
    // MARK: Flickr Parameter Keys
    struct ParameterKeys {
        static let Email = "email"
        static let Style = "style"
    }
    
    // MARK: Flickr Parameter Values
    struct FlickrParameterValues {
        static let Style = "dictionary"
    }
}


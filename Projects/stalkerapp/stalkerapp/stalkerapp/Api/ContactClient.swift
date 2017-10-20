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
    
    func getPhotoData(person:Person, completionHandler: @escaping()->Void){
        let url = URL(string:person.photoUrl!)
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request){
            (data,response,error) in
            guard let httpStatus: Int = (response as! HTTPURLResponse).statusCode, httpStatus>199 && httpStatus<=299 else{
                completionHandler()
                return
            }
            DispatchQueue.main.async {
                do{
                    person.photo = data
                    try LocalDB.shared.stack?.context.save()
                    completionHandler()
                }catch{
                    completionHandler()
                }
                
            }
            
        }
        task.resume()
    }
    
    func loadData(email:String , handler:@escaping (Person?,[SocialMedia]?,Int)->Void){
        
        let parameters: [String: AnyObject] = [
            Client.ParameterKeys.Email: email as AnyObject,
            Client.ParameterKeys.Style: Client.ParameterValues.Style as AnyObject,
            ]
        
        
        
        let session = URLSession.shared
        let request = prepareRequest(url: prepareParameters(parameters))
        
        let task = session.dataTask(with: request){
            (data,response,error) in
            
            
            
            if (error != nil){
                handler(nil,nil,-1)
            }else{
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode>=200 && statusCode<299 else{
                    print("there is an error in your request")
                    handler(nil,nil,((response as? HTTPURLResponse)?.statusCode)!)
                    return
                }
                
                do {
                    let responseData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                    let person = Person(email: email, context: (LocalDB.shared.stack?.context)!)
                    let contactInfo = responseData!["contactInfo"] as! [String:AnyObject]
                    let socialProfiles = responseData!["socialProfiles"] as! [String:AnyObject]
                    let demographics = responseData!["demographics"] as! [String:AnyObject]
                    let photos = responseData!["photos"] as! [String:AnyObject]
                    let locationDeduced = demographics["locationDeduced"] as? [String:AnyObject]
                  
                    person.age = demographics["age"] as? String
                    person.gender = demographics["gender"] as! String
                    person.ageRange = (demographics["ageRange"] as? String)
                    person.fullName = contactInfo["fullName"] as! String
                    if(locationDeduced != nil){
                        person.address = locationDeduced!["deducedLocation"] as? String
                    }
                    
                    // MARK: Photo setting
                    if(photos.keys.count>0){
                        var urls = [String]()
                        for (key,value) in photos {
                            let photoArray = value as! [[String:AnyObject]]
                            for (photoDict) in photoArray {
                                urls.append(photoDict["url"] as! String)
                            }
                        }
                        let randomIndex = Int(arc4random_uniform(UInt32(urls.count)))
                        person.photoUrl =  urls[randomIndex]
                    }
                    var socialMedias = [SocialMedia]()
                    for (key, value) in socialProfiles {
                        
                        let socialMediaArray = value as! [[String:AnyObject]]
                        for (socialMediaDict) in socialMediaArray{
                            
                            
                            let typeName = socialMediaDict["typeName"]
                            let url = socialMediaDict["url"]
                            var username = ""
                            if let usernameTest = socialMediaDict["username"] {
                                username = usernameTest as! String
                            }else{
                                if let userIdTest = socialMediaDict["userid"] {
                                    username = userIdTest as! String
                                }else{
                                    username = ""
                                }
                            }
                            var socialMediaObj = SocialMedia(typeName: typeName! as! String, url: url! as! String, username: username as! String, context: (LocalDB.shared.stack?.context)!)
                            socialMediaObj.person = person
                            socialMediaObj.date = Date()
                            socialMedias.append(socialMediaObj)
                            
                        }
                        
                    }
                    
                    handler(person,socialMedias,200)
                    
                }catch{
                    print( "error parsing response")
                }
            }
        }
        task.resume()
        
        
        
    }
    
    
    
    
    
    
    private func prepareParameters(_ parameters: [String: AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Client.FullContact.APIScheme
        components.host = Client.FullContact.APIHost
        components.path = Client.FullContact.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        print(components.url)
        return components.url!
    }
    
    private func prepareRequest(url:URL)-> URLRequest{
        let request = NSMutableURLRequest(url: url)
        request.addValue(Client.HeaderValues.Authorization, forHTTPHeaderField: Client.HeadersKeys.Authorization)
        request.httpMethod = "GET"
        return request as! URLRequest
    }
    
    
    
}


extension Client {
    struct FullContact {
        static let APIScheme = "https"
        static let APIHost = "api.fullcontact.com"
        static let APIPath = "/v2/person.json"
    }
    
    // MARK: Flickr Parameter Keys
    struct ParameterKeys {
        static let Email = "email"
        static let Style = "style"
    }
    
    struct HeadersKeys{
        static let Authorization = "X-FullContact-APIKey"
    }
    
    struct HeaderValues{
        static let Authorization = "b62915cfed1bb3e1"
    }
    
    // MARK: Flickr Parameter Values
    struct ParameterValues {
        static let Style = "dictionary"
    }
}


//
//  APIManager.swift
//  TabbedBarExample
//
//  Created by Prathamesh Salawkar on 15/02/18.
//  Copyright © 2018 Prathamesh Salawkar. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

typealias ServiceResponse = (JSON, NSError?) -> Void

class APIManager: NSObject {
    enum WebServiceNames: String {
        case baseUrl = "http://54.173.150.242:3500/"
        case UserLogin = "------------"
    }
    
    public static let sharedInstance = APIManager()
    
    var selectedTask:[String:AnyObject] = [:]

    //MARK :- Post
    func postWebService(urlString: String, params: [String : AnyObject], completion : @escaping (_ response : AnyObject?, _ message: String?, _ success : Bool)-> Void) {
        alamofireFunction(urlString: urlString, method: .post, paramters: params) { (response, message, success) in
            if response != nil {
                completion(response as AnyObject?, "", true)
            }else{
                completion(nil, "", false)
            }
        }
    }
    
 
    
    func alamofireFunction(urlString : String, method : Alamofire.HTTPMethod, paramters : [String : AnyObject], completion : @escaping (_ response : AnyObject?, _ message: String?, _ success : Bool)-> Void){
        
        let totalURL = (WebServiceNames.baseUrl.rawValue+urlString)
        
        if method == Alamofire.HTTPMethod.post {
            Alamofire.request(totalURL, method: .post, parameters: paramters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                print(urlString)
                
                if response.result.isSuccess{
                    completion(response.result.value as AnyObject?, "", true)
                }else{
                    completion(nil, "", false)
                }
            }
            
        }else if method == Alamofire.HTTPMethod.patch {
            Alamofire.request(totalURL, method: .patch, parameters: paramters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                print(urlString)
                
                if response.result.isSuccess{
                    completion(response.result.value as AnyObject?, "", true)
                }else{
                    completion(nil, "", false)
                }
            }
            
        }
        else {
            Alamofire.request(totalURL).responseJSON { (response) in
                
                if response.result.isSuccess{
                    completion(response.result.value as AnyObject?, "", true)
                }else{
                    completion(nil, "", false)
                }
            }
        }
    }
    
    
    
    //Mark:-Cancel
    class func cancelAllRequests()
    {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
    
    
//    func postHttpCall(parameters:Dictionary) -> Void {
//        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
// 
//        //create the session object
//        let session = URLSession.shared
//        
//        //now create the URLRequest object using the url object
//        var request = URLRequest(url: WebServiceNames.baseUrl)
//        request.httpMethod = "POST" //set http method as POST
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        //create dataTask using the session object to send data to the server
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//            
//            guard error == nil else {
//                return
//            }
//            
//            guard let data = data else {
//                return
//            }
//            
//            do {
//                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
//                    // handle json...
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        })
//        task.resume()
//    }
    
}

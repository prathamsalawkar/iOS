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
    
 
    
}

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
    // MARK: - Login Variables
    var loginData : NSDictionary?
    
    class func userLogin(userName: String,password : String,userType : String, completion : @escaping (_ response : AnyObject?, _ message: String?, _ success : Bool)-> ()) {
        let url = WebServiceNames.baseUrl.rawValue + WebServiceNames.UserLogin.rawValue
        let params = ["USER": userName,"PASS":password,"API_Key" : userType]
        WebServices.postWebService(urlString: url, params: params as [String : AnyObject]) { (response, message, status) in
            print(response ?? "Error")
            let result = WebServices()
            if let data = response as? NSDictionary {
                print(data)
                result.loginData = data
                completion(result, "Success", true)
                
            }else {
                completion("" as AnyObject?, "Failed", false)
            }
        }
    }
    //MARK :- Post
    class func postWebService(urlString: String, params: [String : AnyObject], completion : @escaping (_ response : AnyObject?, _ message: String?, _ success : Bool)-> Void) {
        alamofireFunction(urlString: urlString, method: .post, paramters: params) { (response, message, success) in
            if response != nil {
                completion(response as AnyObject?, "", true)
            }else{
                completion(nil, "", false)
            }
        }
    }
    
    class func alamofireFunction(urlString : String, method : Alamofire.HTTPMethod, paramters : [String : AnyObject], completion : @escaping (_ response : AnyObject?, _ message: String?, _ success : Bool)-> Void){
        
        if method == Alamofire.HTTPMethod.post {
            Alamofire.request(urlString, method: .post, parameters: paramters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                print(urlString)
                
                if response.result.isSuccess{
                    completion(response.result.value as AnyObject?, "", true)
                }else{
                    completion(nil, "", false)
                }
            }
            
        }else {
            Alamofire.request(urlString).responseJSON { (response) in
                
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

//
//  Networking.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class Networking {
    
    class func Get(urlString: String, successBlock :@escaping (JSON)->(), errorBlock : @escaping (Error)->())  {
        
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "Get"
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60.0
        sessionConfig.timeoutIntervalForResource = 60.0
        
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: urlRequest) { (dataResponse, urlResponse, error) in
            
            if let err = error {
                errorBlock(err)
                return
            }
            
            if let data = dataResponse {
                let resp = getJSONFromData(data: data)
                
                if let err = resp.1 {
                    
                    if let str = String(data: data, encoding: String.Encoding.isoLatin1) {
                        let jsonResp = convertStringToJson(str: str, error: err)
                        
                        if let error = jsonResp.1 {
                            
                            errorBlock(error)
                            
                        } else {
                            if let resp = jsonResp.0 {
                                successBlock(JSON(resp))
                                
                            }
                        }
                        
                    } else {
                        errorBlock(err)
                    }
                    
                } else {
                    if let resp = resp.0 {
                        successBlock(JSON(resp))
                    }
                }
            }
        }
        task.resume()
    }
    
    //Download file from url
    class func download(urlString : String, successBlock :@escaping (URL)->(), errorBlock :@escaping (Error)->()) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        
        let downloadTask = urlSession.downloadTask(with: url) { (fileUrl, urlResp, error) in
            
            if let err = error {
                errorBlock(err)
            } else {
                if let url = fileUrl {
                    successBlock (url)
                }
            }
        }
        downloadTask.resume()

    }
    

    
    private class func convertStringToJson(str: String, error: Error) ->  (Any?, Error?){
        if let dataObj = str.data(using: String.Encoding.utf8) {
            return getJSONFromData(data: dataObj)
        } else {
            return (nil,error)
        }
    }
    
    private class func getJSONFromData(data: Data) -> (Any?, Error?) {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            return (json,nil)
        }
        catch let err {
            return (nil,err)
        }
    }
    
}


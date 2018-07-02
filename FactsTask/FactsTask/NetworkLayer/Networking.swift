//
//  Networking.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import Foundation

class Networking {
    //    static let shared = Networking()
    
    class func Get(urlString: String, successBlock :@escaping (Any)->(), errorBlock : @escaping (Error)->())  {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
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
                                successBlock(resp)
                            }
                        }
                        
                    } else {
                        errorBlock(err)
                    }
                    
                } else {
                    if let resp = resp.0 {
                        successBlock(resp)
                    }
                }
            }
        }
        task.resume()
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


//
//  WebServices.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import Foundation

struct WebServiceUrl {
    
    static var baseURL : String {
        return "https://dl.dropboxusercontent.com"
    }
    
    static var  actURL : String! {
        return baseURL + "/s/2iodh4vg0eortkl/facts.json"
    }
}

class WebServices  {
    
    class func getFactList(completionBlock : @escaping (ListModel)->(),errorBlock: @escaping (Error) -> ()) {
        
        Networking.Get(urlString: WebServiceUrl.actURL, successBlock: { (response) in
            
            if let list = response.dictionary {
                
                let model = ListModel(withData: list)
                completionBlock(model)
                
            }
        }) { (error) in
            
            errorBlock(error)
        }
    }
}



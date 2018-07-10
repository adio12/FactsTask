//
//  FactModel.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import Foundation

import SwiftyJSON


struct ListModel {
    
    var title: String!
    var rowList: [FactsModel]!
    
    init(withData info : [String : JSON]) {
        
        if let title = info["title"] {
            self.title = title.stringValue
        }
        
        var factList = [FactsModel]()
        
        if let rowList = info ["rows"] {
            
            for element in rowList.arrayValue {
                
                let factModel = FactsModel(withListData: element.dictionaryValue)
                factList.append(factModel)
            }
        }
        
        self.rowList = factList
    }
}


struct FactsModel {
    
    var description : String!
    var imgURL : String!
    var title : String!
    
    init(withListData info : [String: JSON]) {
        
        if let description = info ["description"] {
            self.description = description.stringValue
        }
        
        if let imgURL = info ["imageHref"]{
            
            self.imgURL = imgURL.stringValue
        }
        
        if let title = info ["title"]{
            
            self.title = title.stringValue
        }
        
    }
    
}

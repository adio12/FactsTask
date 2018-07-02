//
//  FactViewModel.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import Foundation

struct TableCellModel {
    
    var description : String!
    var imgURL : String!
    var title : String!
    
    init(model : FactsModel) {
        self.description = model.description
        self.title = model.title
        self.imgURL = model.imgURL
    }
}

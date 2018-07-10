//
//  FactDataSource.swift
//  FactsTask
//
//  Created by Aditya Yadav on 10/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import Foundation

class FactDataSource {
    
    var factList = [FactsModel]()
    var title = ""
    
    // Get list from json
    func getList(completionBlock: @escaping ()->(), errorBlock: @escaping (String)->()) {
        WebServices.getFactList(completionBlock: { (listModel) in
            
            self.title = listModel.title ?? ""
            if let list = listModel.rowList {
                self.factList = list
            }
            completionBlock()
            
        }) { (error) in
            
            errorBlock(error.localizedDescription)
        }
    }
    
    func numberOfRows() -> Int {
        return factList.count
    }
    
    func getTitle() -> String {
        return title
    }
    
    func dataForCell(index: Int) -> FactViewModel {
        let model = factList[index]
        let viewModel = FactViewModel(model: model)
        return viewModel
    }
}

extension FactViewModel {
    
    init(model : FactsModel) {
        self.description = model.description
        self.title = model.title
        self.imgURL = model.imgURL
    }
}

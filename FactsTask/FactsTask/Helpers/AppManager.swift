//
//  AppManager.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import Foundation


class AppManager {
    
    static let shared = AppManager()
    
    // cache to store downloaded images
    let cache = NSCache<AnyObject, AnyObject>()
    
    private init() {
    }
}

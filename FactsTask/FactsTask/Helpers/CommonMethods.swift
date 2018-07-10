//
//  CommonMethods.swift
//  FactsTask
//
//  Created by Aditya Yadav on 02/07/18.
//  Copyright © 2018 Aditya Yadav. All rights reserved.
//

import UIKit
import Foundation


class CommonMethods {
    
    class func getErrorObj(_ withString: String?) -> NSError {
        
        let userInfo: [AnyHashable: Any] = [
            
            NSLocalizedDescriptionKey: NSLocalizedString("Error", value: withString ?? Constant.kSomethingWentWrong, comment: "")
        ]
        
        let errorFinal: NSError  = NSError.init(domain: "", code: 8888, userInfo: userInfo as? [String: Any])
        return errorFinal
    }
    
    
    // Alert View
   class func showAlertViewController(viewController: UIViewController, withAlertTitle title: String?, withAlertMessage message: String?) {
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (_: UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}


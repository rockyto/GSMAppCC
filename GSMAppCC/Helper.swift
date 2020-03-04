//
//  Helper.swift
//  GSMAppCC
//
//  Created by Rodrigo Sánchez on 03/03/20.
//  Copyright © 2020 Rodrigo Sánchez. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    func isValid(email: String) -> Bool{
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: email)
        return result
        
    }
    
    func isValid(nombre: String) -> Bool{
        
        let regex = "[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: nombre)
        return result
        
    }
    
    func showAlert(title: String, message: String, in vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
        
    }
    
}

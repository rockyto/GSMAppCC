//
//  ViewController.swift
//  GSMAppCC
//
//  Created by Rodrigo Sánchez on 26/02/20.
//  Copyright © 2020 Rodrigo Sánchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnAcceso: UIButton!
    @IBOutlet weak var userLoginTXT: UITextField!
    @IBOutlet weak var userPsswdTXT: UITextField!
    
    
    override func viewDidLoad() {
        
    // Do any additional setup after loading the view.
        
    super.viewDidLoad()
        
        textFiedlsRounded(for: userLoginTXT)
        textFiedlsRounded(for: userPsswdTXT)
        confBtn()
        
    }
    
    func confBtn(){
        
        btnAcceso.layer.cornerRadius = 20
        btnAcceso.layer.masksToBounds = true
        
    }
    
    func textFiedlsRounded(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    


}


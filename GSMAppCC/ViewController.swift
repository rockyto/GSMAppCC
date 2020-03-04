//
//  ViewController.swift
//  GSMAppCC
//
//  Created by Rodrigo Sánchez on 26/02/20.
//  Copyright © 2020 Rodrigo Sánchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnAcceso: UIButton!
    @IBOutlet weak var userLoginTXT: UITextField!
    @IBOutlet weak var userPsswdTXT: UITextField!
    
    
    override func viewDidLoad() {
        
    // Do any additional setup after loading the view.
        
    super.viewDidLoad()
        
//        userLoginTXT.delegate = self
//        userPsswdTXT.delegate = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion: )), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        textFiedlsRounded(for: userLoginTXT)
        textFiedlsRounded(for: userPsswdTXT)
        padding(for: userLoginTXT)
        padding(for: userPsswdTXT)
        confBtn()
        
    }
    
//    @objc func teclado(notificacion: Notification){
//
//        guard let tecladoSube = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
//            return
//        }
//
//        if notificacion.name == UIResponder.keyboardWillShowNotification{
//
//            self.view.frame.origin.y = -tecladoSube.height
//
//        }else{
//
//            self.view.frame.origin.y = 0
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        self.view.endEditing(true)
//
//    }
    
    func confBtn(){
        
        btnAcceso.layer.cornerRadius = 15
        btnAcceso.layer.masksToBounds = true
        
    }
    
    func textFiedlsRounded(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    func padding(for textField: UITextField){
        
        let blankView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: -10))
        textField.leftView = blankView
        textField.leftViewMode = .always
        
    }


}


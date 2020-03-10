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
    self.hideKeyboardWhenTappedAround()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        confBtn()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.userLoginTXT.text = ""
        self.userPsswdTXT.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userLoginTXT.text = ""
        self.userPsswdTXT.text = ""
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
        self.userLoginTXT.text = ""
        self.userPsswdTXT.text = ""
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
//    func loginGSM(){
//
//        let url = URL(string: "http://localhost/API-movil/clientRegisterCC.php")!
//        let body = "name=\()lastname=\()address=\()suburb=\()zip=\()&town=\()&city=\()&cell=\()&birthday=\()&age=\()&genre=\()&mail=\()"
//
//    }
    
    @IBAction func loginBtn(_ sender: AnyObject) {
        
       loginGSM()
        
    }
    func loginGSM(){
        
        let url = URL(string: "http://localhost/API-movil/loginCC.php")!
        let body = "user=\(userLoginTXT.text!)&password=\(userPsswdTXT.text!)"
        
        var request = URLRequest(url: url)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                let helper = Helper()
                
                if error != nil{
                    
                    helper.showAlert(title: "Error en el servidor", message: error!.localizedDescription, in: self)
                    return
                    
                }
                do{
                    guard let data = data else{
                        
                        helper.showAlert(title: "Error de datos", message: error!.localizedDescription, in: self)
                        
                        return
                    }
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    guard let parsedJSON = json else{
                        print ("Error de parsing")
                        return
                    }
                    
                    if parsedJSON["status"] as! String == "200"{
                        
                    print(json)
                        
                    UserDefaults.standard.set(parsedJSON["CCid"], forKey: "CCid")
                    UserDefaults.standard.synchronize()
                    let iDCC: String = UserDefaults.standard.string(forKey: "CCid")!
                    print("El ID del Centro Comercial es: ",iDCC)
                        self.userLoginTXT.text = ""
                        self.userPsswdTXT.text = ""
                    helper.instantiateViewController(identifier: "vistaTabla", animated: true, by: self, completion: nil)
                        
                    }else if parsedJSON["status"] as! String == "404" || parsedJSON["status"] as! String == "401"{
                        
                        helper.showAlert(title: "JSON Error", message: parsedJSON["message"] as! String, in: self)
                        
                    }
                   }catch{
                        
                        helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
                        
                    }
            }
        }.resume()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.view.endEditing(true)

    }
    
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


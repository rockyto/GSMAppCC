//
//  FormRegisterVC.swift
//  GSMAppCC
//
//  Created by Rodrigo Sánchez on 26/02/20.
//  Copyright © 2020 Rodrigo Sánchez. All rights reserved.
//

import SQLite
import UIKit


class FormRegisterVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var idRecordCC: Int = 0
    let helper = Helper()

    var currentTextField = UITextField()
    
    let dataSource = ["-Genero-", "Hombre", "Mujer", "Prefiero no decirlo"]
    let dataSourceAge = ["-Rango de edad-","15-25", "26-35", "36-45", "46-55", "56-65", "65 o más"]
    
    var generoPicker = UIPickerView()
    var rangoEdadPicker = UIPickerView()
    
    //Constraints
    @IBOutlet weak var personalData: NSLayoutConstraint!
    @IBOutlet weak var addressData: NSLayoutConstraint!
    @IBOutlet weak var contactData: NSLayoutConstraint!
    @IBOutlet weak var footView: UIView!
    
//    var edadPicker: UIPickerView!
//    var genrepicker: UIPickerView!
    
    //Componentes
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView_width: NSLayoutConstraint!
    
    //TextFields
    //Información personal
    @IBOutlet weak var nameClienTxt: UITextField!
    @IBOutlet weak var lastNameClientTxt: UITextField!
    @IBOutlet weak var genreClientTxt: UITextField!
    //@IBOutlet weak var birthClientTxt: UITextField!
    @IBOutlet weak var rangoEdadClientTxt: UITextField!
    
    //Direccion
  //@IBOutlet weak var addressClientTxt: UITextField!
    @IBOutlet weak var suburbClientTxt: UITextField!
    @IBOutlet weak var zipCodeClientTxt: UITextField!
    @IBOutlet weak var townClientTxt: UITextField!
    @IBOutlet weak var cityClientTxt: UITextField!
    
    //Contacto
    @IBOutlet weak var mailClientTxt: UITextField!
    @IBOutlet weak var telClientTxt: UITextField!
    
    //Colección de botones
    @IBOutlet weak var continuaDataBtn: UIButton!
    @IBOutlet weak var continuaAddressBtn: UIButton!
    @IBOutlet weak var finishContactBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        genreClientTxt.delegate = self
        rangoEdadClientTxt.delegate = self
        
        generoPicker.delegate = self
        generoPicker.dataSource = self
        
        rangoEdadPicker.delegate = self
        rangoEdadPicker.dataSource = self
        
        genreClientTxt.inputView = generoPicker
        rangoEdadClientTxt.inputView = rangoEdadPicker
        
        contentView_width.constant = self.view.frame.width * 3
        personalData.constant = self.view.frame.width
        addressData.constant = self.view.frame.width
        contactData.constant = self.view.frame.width
        
        textRoundedTextFields(for: nameClienTxt)
        textRoundedTextFields(for: lastNameClientTxt)
        textRoundedTextFields(for: genreClientTxt)
        textRoundedTextFields(for: rangoEdadClientTxt)
        
      //textRoundedTextFields(for: addressClientTxt)
        textRoundedTextFields(for: suburbClientTxt)
        textRoundedTextFields(for: zipCodeClientTxt)
        textRoundedTextFields(for: townClientTxt)
        textRoundedTextFields(for: cityClientTxt)
        
        textRoundedTextFields(for: mailClientTxt)
        textRoundedTextFields(for: telClientTxt)
        
        padding(for: nameClienTxt)
        padding(for: lastNameClientTxt)
        padding(for: genreClientTxt)
        padding(for: rangoEdadClientTxt)
  //    padding(for: addressClientTxt)
        padding(for: suburbClientTxt)
        padding(for: zipCodeClientTxt)
        padding(for: townClientTxt)
        padding(for: cityClientTxt)
        padding(for: mailClientTxt)
        padding(for: telClientTxt)
        
        botonesRedondos(for: continuaDataBtn)
        botonesRedondos(for: continuaAddressBtn)
        botonesRedondos(for: finishContactBtn)
        
        configure_footerView()

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handle(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        // Do any additional setup after loading the view.
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        print("Ejecuta acción")
        return true
    }
    
    
    @objc func handle(_ gesture: UISwipeGestureRecognizer){
        
        let current_x = scrollView.contentOffset.x
        let screen_width = self.view.frame.width
        let new_x = CGPoint(x: current_x - screen_width, y:0)
        
        if current_x > 0{
            
            scrollView.setContentOffset(new_x, animated: true)
        
        }
    }
    
    @IBAction func cancelaClicked(_ sender: Any){
        
        nameClienTxt.text = ""
        lastNameClientTxt.text = ""
        genreClientTxt.text = ""
        rangoEdadClientTxt.text = ""
     // addressClientTxt.text = ""
        suburbClientTxt.text = ""
        zipCodeClientTxt.text = ""
        townClientTxt.text = ""
        cityClientTxt.text = ""
        mailClientTxt.text = ""
        telClientTxt.text = ""
        
        let position = CGPoint(x:0, y:0)
        scrollView.setContentOffset(position, animated: true)
        
    }
    
    @IBAction func continuaPDB_clicked(_ sender: Any){
            
        if nameClienTxt.text!.isEmpty == false && lastNameClientTxt.text!.isEmpty == false && genreClientTxt.text!.isEmpty == false{
            
            nameClienTxt.resignFirstResponder()
            
            let position = CGPoint(x:self.view.frame.width, y:0)
            scrollView.setContentOffset(position, animated: true)
            
        }else{
            nameClienTxt.becomeFirstResponder()
                      
            helper.showAlert(title: "Atención", message: "Todos los campos marcados con un * son obligatorios", in: self)
            }
        
    }
    
    @IBAction func continuaDB_clicked(_ sender: Any){
        
        if zipCodeClientTxt.text!.isEmpty == false && cityClientTxt.text!.isEmpty == false && suburbClientTxt.text!.isEmpty == false {
            
            zipCodeClientTxt.resignFirstResponder()
            
            let position = CGPoint(x:self.view.frame.width * 2, y:0)
            scrollView.setContentOffset(position, animated: true)
            
        }else{
            
           // addressClientTxt.becomeFirstResponder()
            suburbClientTxt.becomeFirstResponder()
            helper.showAlert(title: "Atención", message: "Todos los campos marcados con un * son obligatorios", in: self)
            
        }
        
    }
    
    @IBAction func continuaCB_clicked(_ sender: Any){
        
        if mailClientTxt.text!.isEmpty == false && telClientTxt.text!.isEmpty == false {
        
            guardaLocal()
            
            
        }else{
            
            mailClientTxt.becomeFirstResponder()
            
            helper.showAlert(title: "Atención", message: "Todos los campos marcados con un * son obligatorios", in: self)
            
        }
        
    }
    
    @IBAction func muestraDatosBtn(_ sender: Any){

        muestraDatos()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           
        self.view.endEditing(false)
        nameClienTxt.resignFirstResponder()
        //addressClientTxt.resignFirstResponder()
        telClientTxt.resignFirstResponder()
           
       }
    
    func textRoundedTextFields(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    func botonesRedondos(for view: UIView){
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
    }
    
    func padding(for textField: UITextField){
        
        let blankView = UIView.init(frame: CGRect(x:0, y:0, width: 10, height: -10))
        textField.leftView = blankView
        textField.leftViewMode = .always
        
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        
        if textField == nameClienTxt || textField == lastNameClientTxt{
            
            if helper.isValid(nombre: nameClienTxt.text!) || helper.isValid(nombre: lastNameClientTxt.text!){
                
                continuaDataBtn.isEnabled = true
                print("Nombre valido")
                
            }
            
        }
        
        if textField == mailClientTxt{
            
            if helper.isValid(email: mailClientTxt.text!){
                
                finishContactBtn.isEnabled = true
                
                print("Correo valido")
                
            }
            
        }
        
        
    }
    
    func guardaLocal(){
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity?.labelText = "Registrando"
        spinningActivity?.detailsLabelText = "un momento por favor"
        TableRecords.shared.insertar(id: idRecordCC, nombre: nameClienTxt.text!, apellido: lastNameClientTxt.text!, genero: genreClientTxt.text!, edad: rangoEdadClientTxt.text!, /*direccion: addressClientTxt.text!,*/ colonia: suburbClientTxt.text!, zip: zipCodeClientTxt.text!, municipio: townClientTxt.text!, ciudad: cityClientTxt.text!, mail: mailClientTxt.text!, cel: telClientTxt.text!) //, id_cc: idCCGSM
         
        spinningActivity?.hide(true)
        let myAlert = UIAlertController(title: "Gracias", message: "Registro Exitoso", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(alertAction) in
            
            let position = CGPoint(x:0, y:0)
            self.scrollView.setContentOffset(position, animated: true)
            self.nameClienTxt.text = ""
            self.lastNameClientTxt.text = ""
            self.genreClientTxt.text = ""
            self.rangoEdadClientTxt.text = ""
            //self.addressClientTxt.text = ""
            self.suburbClientTxt.text = ""
            self.zipCodeClientTxt.text = ""
            self.townClientTxt.text = ""
            self.cityClientTxt.text = ""
            self.mailClientTxt.text = ""
            self.telClientTxt.text = ""
            
        })
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion: nil)
        
    }
    
    func muestraDatos(){
        TableRecords.shared
        for row in (try! Database.shared.conexion?.prepare("SELECT * FROM recordsClientsCC"))! {

             print("id: \(row[0]!), nombre: \(row[1]!), apellido: \(row[2]!), genero: \(row[3]!), edad: \(row[4]!), colonia: \(row[5]!), zip: \(row[6]!), municipio: \(row[7]!), ciudad: \(row[8]!), mail: \(row[9]!), cel: \(row[10]!)")

         }
        
    }
   
    
    
    func configure_footerView(){
        
        let topLine = CALayer()
        topLine.borderWidth = 1
        topLine.borderColor = UIColor.lightGray.cgColor
        topLine.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
        footView.layer.addSublayer(topLine)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if currentTextField == genreClientTxt{
            
            return dataSource.count
            
        }else if currentTextField == rangoEdadClientTxt{
            
            return dataSourceAge.count
            
        }else{
            
            return 0
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if currentTextField == genreClientTxt{
            
            if row == 0{
                
                generoPicker.selectRow(row+1, inComponent: component, animated: true)
                  
              }else{
                  
                genreClientTxt.text = dataSource[row]
                self.view.endEditing(true)
                  
              }
            
        }else if currentTextField == rangoEdadClientTxt{
            
            if row == 0{
                
                rangoEdadPicker.selectRow(row+1, inComponent: component, animated: true)
                
            }else{
                
                rangoEdadClientTxt.text = dataSourceAge[row]
                self.view.endEditing(true)
                
            }
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if currentTextField == genreClientTxt{
            
            return dataSource[row]
            
        }else if currentTextField == rangoEdadClientTxt{
            
            return dataSourceAge[row]
            
        }
        
        return ""
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        currentTextField = textField
        
        if currentTextField == genreClientTxt{
            
            currentTextField.inputView = generoPicker
            
        }else if currentTextField == rangoEdadClientTxt{
            
            currentTextField.inputView = rangoEdadPicker
            
        }
       
    }

}

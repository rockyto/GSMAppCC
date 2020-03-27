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
    
    //var idCCGSM: Int = 0
    var idRecordCC: Int = 0
    let helper = Helper()
    var clientBirth: String = ""
    var clientAge: Int = 0
    let dataSource = ["Hombre", "Mujer", "Prefiero no decirlo"]
    
    var generoPicker = UIPickerView()
    
    //Constraints
    @IBOutlet weak var personalData: NSLayoutConstraint!
    @IBOutlet weak var addressData: NSLayoutConstraint!
    @IBOutlet weak var contactData: NSLayoutConstraint!
    @IBOutlet weak var footView: UIView!
    
    var datePicker: UIDatePicker!
    var genrepicker: UIPickerView!
    
    //Componentes
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView_width: NSLayoutConstraint!
    
    //TextFields
    //Información personal
    @IBOutlet weak var nameClienTxt: UITextField!
    @IBOutlet weak var lastNameClientTxt: UITextField!
    @IBOutlet weak var genreClientTxt: UITextField!
    @IBOutlet weak var birthClientTxt: UITextField!
    
    //Direccion
    @IBOutlet weak var addressClientTxt: UITextField!
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
//        nameClienTxt.delegate = self
//        lastNameClientTxt.delegate = self
        genreClientTxt.delegate = self
        birthClientTxt.delegate = self
//
//        NotificationCenter.default.addObserver(self, selector: #selector(tecla2(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(tecla2(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(tecla2(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        generoPicker.delegate = self
        generoPicker.dataSource = self
        genreClientTxt.inputView = generoPicker
        
        contentView_width.constant = self.view.frame.width * 3
        personalData.constant = self.view.frame.width
        addressData.constant = self.view.frame.width
        contactData.constant = self.view.frame.width
        
        textRoundedTextFields(for: nameClienTxt)
        textRoundedTextFields(for: lastNameClientTxt)
        textRoundedTextFields(for: genreClientTxt)
        textRoundedTextFields(for: birthClientTxt)
        
        textRoundedTextFields(for: addressClientTxt)
        textRoundedTextFields(for: suburbClientTxt)
        textRoundedTextFields(for: zipCodeClientTxt)
        textRoundedTextFields(for: townClientTxt)
        textRoundedTextFields(for: cityClientTxt)
        
        textRoundedTextFields(for: mailClientTxt)
        textRoundedTextFields(for: telClientTxt)
        
        padding(for: nameClienTxt)
        padding(for: lastNameClientTxt)
        padding(for: genreClientTxt)
        padding(for: birthClientTxt)
        padding(for: addressClientTxt)
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
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -5, to: Date())
        datePicker.addTarget(self, action: #selector(self.datePickerDidChange(_:)), for: .valueChanged)
        birthClientTxt.inputView = datePicker
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handle(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        // Do any additional setup after loading the view.
        
    }
    

    
//    @objc func tecla2(notificacion: Notification){
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
//
//        }
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        print("Ejecuta acción")
        return true
    }
    
    @objc func datePickerDidChange(_ datePicker: UIDatePicker){
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        birthClientTxt.text = formatter.string(from: datePicker.date)
        
        let compareDateFormatter = DateFormatter()
        compareDateFormatter.dateFormat = "yyyy/MM/dd"
        let compareDate = compareDateFormatter.date(from: "2002/01/01")
        
        let birthSelect = DateFormatter()
        birthSelect.dateFormat = "yyyy/MM/dd"
        clientBirth = birthSelect.string(from: datePicker.date)
        
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
        birthClientTxt.text = ""
        addressClientTxt.text = ""
        suburbClientTxt.text = ""
        zipCodeClientTxt.text = ""
        townClientTxt.text = ""
        cityClientTxt.text = ""
        mailClientTxt.text = ""
        telClientTxt.text = ""
        
        let position = CGPoint(x:0, y:0)
        scrollView.setContentOffset(position, animated: true)
        
//        let current_x = scrollView.contentOffset.x
//        let screen_width = self.view.frame.width
//        let new_x = CGPoint(x: current_x - screen_width, y:0)
//
//        if current_x > 0{
//
//            scrollView.setContentOffset(new_x, animated: true)
//
//        }
        
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
        
        if zipCodeClientTxt.text!.isEmpty == false && cityClientTxt.text!.isEmpty == false {
            
            zipCodeClientTxt.resignFirstResponder()
            
            let position = CGPoint(x:self.view.frame.width * 2, y:0)
            scrollView.setContentOffset(position, animated: true)
            
        }else{
            
            addressClientTxt.becomeFirstResponder()
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
        addressClientTxt.resignFirstResponder()
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
        
        if birthClientTxt.text!.isEmpty == false{
            
            let fechaString: String = clientBirth
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let fechaDate =  dateFormatter.date(from: fechaString)!
            
            let now = Date()
            let elCumple: Date = fechaDate
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents(([.year]), from: elCumple, to: now)
            let edad = ageComponents.year!
            clientAge = edad
            
        }
    
        
        TableRecords.shared.insertar(id: idRecordCC, nombre: nameClienTxt.text!, apellido: lastNameClientTxt.text!, cumple: clientBirth, genero: genreClientTxt.text!, edad: clientAge, direccion: addressClientTxt.text!, colonia: suburbClientTxt.text!, zip: zipCodeClientTxt.text!, municipio: townClientTxt.text!, ciudad: cityClientTxt.text!, mail: mailClientTxt.text!, cel: telClientTxt.text!) //, id_cc: idCCGSM
        
        let myAlert = UIAlertController(title: "Gracias", message: "Registro Exitoso", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(alertAction) in
            
            let position = CGPoint(x:0, y:0)
            self.scrollView.setContentOffset(position, animated: true)
            
            self.nameClienTxt.text = ""
            self.lastNameClientTxt.text = ""
            self.genreClientTxt.text = ""
            self.birthClientTxt.text = ""
            self.addressClientTxt.text = ""
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

             print("id: \(row[0]!), nombre: \(row[1]!), apellido: \(row[2]!), cumple: \(row[3]!), genero: \(row[4]!), edad: \(row[5]!), dirección: \(row[6]!), colonia: \(row[7]!), zip: \(row[8]!), municipio: \(row[9]!), ciudad: \(row[10]!), mail: \(row[11]!), cel: \(row[12]!)") //, id_cc: \(row[13]!)

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
        
        return dataSource.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        genreClientTxt.text = dataSource[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataSource[row]
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


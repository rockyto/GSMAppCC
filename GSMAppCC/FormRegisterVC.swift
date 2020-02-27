//
//  FormRegisterVC.swift
//  GSMAppCC
//
//  Created by Rodrigo Sánchez on 26/02/20.
//  Copyright © 2020 Rodrigo Sánchez. All rights reserved.
//

import UIKit

class FormRegisterVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var clientBirth: String = ""
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
        
        generoPicker.delegate = self
        generoPicker.dataSource = self
        genreClientTxt.inputView = generoPicker
        
        contentView_width.constant = self.view.frame.width * 5
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
        
        padding(for: nameClienTxt)
        padding(for: lastNameClientTxt)
        padding(for: genreClientTxt)
        padding(for: birthClientTxt)
        padding(for: addressClientTxt)
        padding(for: suburbClientTxt)
        padding(for: zipCodeClientTxt)
        padding(for: townClientTxt)
        padding(for: cityClientTxt)
        
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
        
        if current_x > 0 {
            
            scrollView.setContentOffset(new_x, animated: true)
        }
    }
    
    @IBAction func continuaPDB_clicked(_ sender: Any){
        
        let position = CGPoint(x:self.view.frame.width, y:0)
        scrollView.setContentOffset(position, animated: true)
        
    }
    
    @IBAction func continuaDB_clicked(_ sender: Any){
        
        let position = CGPoint(x:self.view.frame.width * 2, y:0)
        scrollView.setContentOffset(position, animated: true)
        
    }
    
    @IBAction func continuaCB_clicked(_ sender: Any){
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
        
        
    }
    
    func textRoundedTextFields(for view: UIView){
        
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
    }
    
    func botonesRedondos(for view: UIView){
        
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        
    }
    
    func padding(for textField: UITextField){
        
        let blankView = UIView.init(frame: CGRect(x:0, y:0, width: 10, height: -10))
        textField.leftView = blankView
        textField.leftViewMode = .always
        
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

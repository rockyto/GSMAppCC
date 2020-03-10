//
//  SubirRegistroVC.swift
//  GSMAppCC
//
//  Created by Rodrigo Sánchez on 09/03/20.
//  Copyright © 2020 Rodrigo Sánchez. All rights reserved.
//

import UIKit

class SubirRegistroVC: UIViewController {
    
    var nombre = ""
    var apellido = ""
    var cumple = ""
    var genero = ""
    var edad: Int = 0
    var direccion = ""
    var colonia = ""
    var zip = ""
    var municipio = ""
    var ciudad = ""
    var mail = ""
    var cel = ""
    
   // static let shared = TableRecords()
    
    var registrosASubir : Registros!

    @IBOutlet weak var btnSi: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnEliminar: UIButton!
    
    override func viewDidLoad() {
        
        botonesRedondos(for: btnSi)
        botonesRedondos(for: btnNo)
        botonesRedondos(for: btnEliminar)
        
        print("----Datos obligatorios----")
        print("IDRegistro: \(registrosASubir.id)")
        print("Nombre: \(registrosASubir.nombre)\t")
        print("Apellido: \(registrosASubir.apellido)\t")
        print("Zip: \(registrosASubir.zip)\t")
        print("Ciudad: \(registrosASubir.ciudad)\t")
        print("Teléfono: \(registrosASubir.cel)\t")
        print("Genero: \(registrosASubir.genero)\t")
        print("Correo: \(registrosASubir.mail)\t")
        
        print("----Datos no obligatorios----")
        print("Cumpleaños: \(registrosASubir.cumple)\t")
        print("Edad: \(registrosASubir.edad)\t")
        print("Dirección: \(registrosASubir.direccion)\t")
        print("Colonia: \(registrosASubir.colonia)\t")
        print("Municipio: \(registrosASubir.municipio)\t")
        
        super.viewDidLoad()
        print(registrosASubir!)
        // Do any additional setup after loading the view.
    }
    
    func botonesRedondos(for view: UIView){
         
         view.layer.cornerRadius = 15
         view.layer.masksToBounds = true
         
     }
    
    
    @IBAction func subeRegistro_clicked(_ sender: UIButton) {
        SubeRegistro()
    }
    
    func SubeRegistro(){
        let url = URL(string: "http://localhost/API-movil/clientRegisterCC.php")!
        
        let body = "name=\(registrosASubir.nombre)&lastname=\(registrosASubir.apellido)&zip=\(registrosASubir.zip)&city=\(registrosASubir.ciudad)&cell=\(registrosASubir.cel)&genre=\(registrosASubir.genero)&mail=\(registrosASubir.mail)&address=\(registrosASubir.direccion)&suburb=\(registrosASubir.colonia)&town=\(registrosASubir.municipio)&birthday=\(registrosASubir.cumple)&age=\(registrosASubir.edad)"
        
        print(body)
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
                do {
                    guard let data = data else{
                        helper.showAlert(title: "Error de datos", message: error!.localizedDescription, in: self)
                        return
                    }
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    guard let parsedJSON = json else {
                        print("PARSING ERROR")
                        return
                    }
                    
                    if parsedJSON["status"] as! String == "200"{
                        
                        helper.showAlert(title: "Datos subido", message: "Los datos se han registrado en el servidor", in: self)
                        print(json)
                        
                    }else{
                        if parsedJSON["message"] != nil{
                            let message = parsedJSON["message"] as! String
                            helper.showAlert(title: "Error", message: message, in: self)
                        }
                    }
                }catch{
                    helper.showAlert(title: "JSON Error", message: error.localizedDescription, in: self)
                }
            }
        }.resume()
    }
    
    func EliminarRegistro(){
        
        TableRecords.shared.borrar(ids: registrosASubir.id)
        
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

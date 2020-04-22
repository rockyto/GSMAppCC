//
//  ListaRegistrosVC.swift
//  GSMAppCC
//
//  Created by Rodrigo Sánchez on 04/03/20.
//  Copyright © 2020 Rodrigo Sánchez. All rights reserved.
//

import UIKit

class ListaRegistrosVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    
    var registrosLista = [Registros]()
    
    @IBOutlet weak var tableView: UITableView!
    
    let iDCC: String = UserDefaults.standard.string(forKey: "CCid")!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subir"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let fila = registrosLista[indexPath.row]
                let destino = segue.destination as! SubirRegistroVC
                destino.registrosASubir = fila
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return registrosLista.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecords", for: indexPath)
        let registro = registrosLista[indexPath.row]
        cell.textLabel?.text = registro.nombre
        cell.detailTextLabel?.text = registro.apellido
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          mostrarRegistros()
        
        if registrosLista.isEmpty == true{
            
            tableView.isHidden = true
            
        }else{
            
            tableView.isHidden = false
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if registrosLista.isEmpty == true{
            
            tableView.isHidden = true
            
        }else{
            
            mostrarRegistros()
            tableView.reloadData()
            tableView.isHidden = false
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool){
        
        tableView.reloadData()

    }
    
    @IBAction public func mostrarDatos(_ sender: UIButton){
   
        subeLote()
        registrosLista.removeAll()
        tableView.reloadData()
        
    }
    
    func subeLote(){
         
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity?.labelText = "Subiendo registros"
        spinningActivity?.detailsLabelText = "un momento por favor"
        
        TableRecords.shared
        for row in (try! Database.shared.conexion?.prepare("SELECT * FROM recordsClientsCC"))!{
            
            let id = row[0]! as! Int64
            let nombre = row[1]! as! String
            let apellido = row[2]! as! String
            let genero = row[3]! as! String
            let edad = row[4]! as! String
            let colonia = row[5]! as! String
            let zip = row[6]! as! String
            let municipio = row[7]! as! String
            let ciudad = row[8]! as! String
            let mail = row[9]! as! String
            let cel = row[10]! as! String
            
            
            let url = URL(string: "https://genoclilab.com/API-movil/clientRegisterCC.php")!
            
            let body = "name=\(nombre)&lastname=\(apellido)&zip=\(zip)&city=\(ciudad)&cell=\(cel)&genre=\(genero)&mail=\(mail)&suburb=\(colonia)&town=\(municipio)&age=\(edad)&ccID=\(iDCC)"
            
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
                            
     TableRecords.shared.borrar(ids: id)
     
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
            
            
            print("----INICIA REGISTRO----")
            print("Nombre: \(nombre)\t")
            print("Apellido: \(apellido)\t")
            print("Zip: \(zip)\t")
            print("Ciudad: \(ciudad)\t")
            print("Teléfono: \(cel)\t")
            print("Genero: \(genero)\t")
            print("Correo: \(mail)\t")
            print("Edad: \(edad)\t")
            print("Colonia: \(colonia)\t")
            print("Municipio: \(municipio)\t")
            print("----FINALIZA REGISTRO----\t")
             
        }
        spinningActivity?.hide(true)
        
    }

    func mostrarRegistros(){

        registrosLista.removeAll()
        TableRecords.shared
        for row in (try! Database.shared.conexion?.prepare("SELECT * FROM recordsClientsCC"))! {
            
               let id = row[0]! as! Int64
               let nombre = row[1]! as! String
               let apellido = row[2]! as! String
               let genero = row[3]! as! String
               let edad = row[4]! as! String
               let colonia = row[5]! as! String
               let zip = row[6]! as! String
               let municipio = row[7]! as! String
               let ciudad = row[8]! as! String
               let mail = row[9]! as! String
               let cel = row[10]! as! String
            
            let lista = Registros(id: id, nombre: nombre, apellido: apellido, genero: genero, edad: edad, colonia: colonia, zip: zip, municipio: municipio, ciudad: ciudad, mail: mail, cel: cel)
            
            self.registrosLista.append(lista)
            
         }
    }
    
    @IBAction func btnSalir(_ sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}

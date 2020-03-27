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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subir"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let fila = registrosLista[indexPath.row]
                let destino = segue.destination as! SubirRegistroVC
                destino.registrosASubir = fila
                
//                let nombre = registrosLista[nombre.row]
//                let apellido = registrosLista[.row]
//                let cumple = registrosLista[.row]
//                let genero = registrosLista[.row]
//                let edad = registrosLista[.row]
//                let direccion = registrosLista[.row]
//                let colonia = registrosLista[.row]
//                let zip = registrosLista[.row]
//                let municipio = registrosLista[.row]
//                let ciudad = registrosLista[.row]
//                let mail = registrosLista[.row]
//                let cel = registrosLista[.row]

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
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "subir", sender: self)
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
          mostrarRegistros()
        
        if registrosLista.isEmpty == true{
            
            //tablaHorarios.isHidden = true
            tableView.isHidden = true
            
        }else{
            
            tableView.isHidden = false
        }
        
        // Do any additional setup after loading the view.
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

    
    func mostrarRegistros(){

        registrosLista.removeAll()
        TableRecords.shared
        for row in (try! Database.shared.conexion?.prepare("SELECT * FROM recordsClientsCC"))! {
            
               let id = row[0]! as! Int64
               let nombre = row[1]! as! String
               let apellido = row[2]! as! String
               let cumple = row[3]! as! String
               let genero = row[4]! as! String
               let edad = row[5]! as! Int64
               let direccion = row[6]! as! String
               let colonia = row[7]! as! String
               let zip = row[8]! as! String
               let municipio = row[9]! as! String
               let ciudad = row[10]! as! String
               let mail = row[11]! as! String
               let cel = row[12]! as! String
             //  let id_cc = row[13]! as! Int64
            
            let lista = Registros(id: id, nombre: nombre, apellido: apellido, cumple: cumple, genero: genero, edad: Int(edad), direccion: direccion, colonia: colonia, zip: zip, municipio: municipio, ciudad: ciudad, mail: mail, cel: cel)
            //, id_cc: id_cc
            
            self.registrosLista.append(lista)
            
         }
    }
    
    @IBAction func btnSalir(_ sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
//        let logginView = (self.storyboard?.instantiateViewController(withIdentifier: "tabBarRoot"))
//        let appDelegado = UIApplication.shared.delegate
//        appDelegado?.window??.rootViewController = logginView
        
    }
    
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}

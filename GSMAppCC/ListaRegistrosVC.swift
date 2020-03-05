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
        // Do any additional setup after loading the view.
    }
    
    func mostrarRegistros(){
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//
//  TableRecords.swift
//  
//
//  Created by Rodrigo Sánchez on 03/03/20.
//

import Foundation
import SQLite

class TableRecords {
    
    static let shared = TableRecords()
    
    private let table = Table("recordsClientsCC")
    
    private let id = Expression<Int64>("idCCRecordsClients")
    private let nombre = Expression<String>("clientName")
    private let apellido = Expression<String>("clientLastName")
    
//  private let cumple = Expression<String>("clientBirthday")
    private let genero = Expression<String>("clientGenre")
    private let edad = Expression<String>("clientAge")
    
//  private let direccion = Expression<String>("clientAddress")
    private let colonia = Expression<String>("clientSuburb")
    
    private let zip = Expression<String>("clientZipCode")
    private let municipio = Expression<String>("clientTown")
    private let ciudad = Expression<String>("clientCity")
    private let mail = Expression<String>("clientMail")
    private let cel = Expression<String>("clientCell")
    //private let id_cc = Expression<Int64>("ccID")
    
    private init(){
        do{
            if let conexion = Database.shared.conexion{
                try conexion.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
                                                t.column(self.id, primaryKey: true)
                                                 t.column(self.nombre)
                                                 t.column(self.apellido)
                                               //t.column(self.cumple)
                                                 t.column(self.genero)
                                                 t.column(self.edad)
                                               //t.column(self.direccion)
                                                 t.column(self.colonia)
                                                 t.column(self.zip)
                                                 t.column(self.municipio)
                                                 t.column(self.ciudad)
                                                 t.column(self.mail)
                                                 t.column(self.cel)
                                                // t.column(self.id_cc)
                }))
                
                print("La tabla se creo correctamente")
                
            }else{
                print("La tabla no se creó")
            }
        } catch let error as NSError {
            
            print("La tabla no se creo", error)
            
        }
    }
    
    func insertar(id: Int, nombre: String, apellido: String, genero: String, edad: String, colonia: String, zip: String, municipio: String, ciudad: String, mail: String, cel: String){
        //, id_cc: Int
        do{
            let insertar = table.insert(self.nombre <- nombre, self.apellido <- apellido, self.genero <- genero, self.edad <- edad, self.colonia <- colonia, self.zip <- zip, self.municipio <- municipio, self.ciudad <- ciudad, self.mail <- mail, self.cel <- cel)
            try Database.shared.conexion?.run(insertar)
        } catch let error as NSError{
            print("error al guardar", error)
        }
    }
    
    func borrar(ids: Int64){
        
        let identificador = table.filter(id == ids)
        try! Database.shared.conexion?.run(identificador.delete())
        print("Registro borrado correctamente")
        
    }
    
}

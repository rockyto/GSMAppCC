//
//  Registros.swift
//  GSMAppCC
//
//  Created by Rodrigo Sánchez on 04/03/20.
//  Copyright © 2020 Rodrigo Sánchez. All rights reserved.
//

import Foundation

class Registros{
    
    var id : Int64
    var nombre : String
    var apellido : String
    var cumple : String
    var genero : String
    var edad : Int
    
    var direccion : String
    var colonia : String
    
    var zip : String
    var municipio : String
    var ciudad : String
    var mail : String
    var cel : String
   // var id_cc : Int64
    
    init(id: Int64, nombre: String, apellido: String, cumple: String, genero: String, edad: Int, direccion: String, colonia: String, zip: String, municipio: String, ciudad: String, mail: String, cel: String) {
        //, id_cc: Int64
        
        self.id = id
        self.nombre = nombre
        self.apellido = apellido
        self.cumple = cumple
        self.genero = genero
        self.edad = edad
        self.direccion = direccion
        self.colonia = colonia
        self.zip = zip
        self.municipio = municipio
        self.ciudad = ciudad
        self.mail = mail
        self.cel = cel
       // self.id_cc = id_cc
        
    }
    
}

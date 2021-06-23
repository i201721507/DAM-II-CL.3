//
//  Usuario_BE.swift
//  Examen3
//
//  Created by Renzo on 22/06/21.
//

import Foundation

class Usuario_BE: NSObject{
    
    var Codigo: Int = 0
    var Nombre: String = ""
    var NumeroOrden: String = ""
    var Fecha: String = ""
    var Linea: String = ""
    var Estado: String = ""
    var Obs: String = ""
    
    override init() {
        self.Codigo = 0
        self.Nombre = ""
        self.NumeroOrden = ""
        self.Fecha = ""
        self.Linea = ""
        self.Estado = ""
        self.Obs = ""
    }
    
    init(pCodigo: Int ,pNombre: String, pNumero: String, pfecha: String, pLinea: String, pEstado: String, pObs: String) {
        self.Codigo = pCodigo
        self.Nombre = pNombre
        self.NumeroOrden = pNumero
        self.Fecha = pfecha
        self.Linea = pLinea
        self.Estado = pEstado
        self.Obs = pObs
    }
}

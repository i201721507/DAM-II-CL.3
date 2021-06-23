//
//  ViewControllerNuevoCliente.swift
//  Examen3
//
//  Created by Renzo on 22/06/21.
//

import UIKit
import Foundation

class ViewControllerNuevoCliente: UIViewController {
    
    @IBOutlet weak var tfCodigo: UITextField!
    @IBOutlet weak var tfCliente: UITextField!
    @IBOutlet weak var tfOrden: UITextField!
    @IBOutlet weak var tfFecha: UITextField!
    @IBOutlet weak var tfLinea: UITextField!
    @IBOutlet weak var tfEstado: UITextField!
    @IBOutlet weak var tfObs: UITextField!
    @IBOutlet weak var lblMensaje: UILabel!
    
    var oUser: Usuario_BE = Usuario_BE()
    var ACCION: String = "N"
    func CargarDatos(pUser: Usuario_BE){
        oUser = pUser
    }
    
    func MostrarDatos(){
        
        self.tfCodigo.text = String (oUser.Codigo)
        self.tfCliente.text = String (oUser.Nombre)
        self.tfOrden.text = String (oUser.NumeroOrden)
        self.tfFecha.text = String (oUser.Fecha)
        self.tfLinea.text = String (oUser.Linea)
        self.tfEstado.text = String (oUser.Estado)
        self.tfObs.text = String (oUser.Obs)
        
    }
    
    @IBAction func btnListado(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnGrabar(_ sender: Any) {
        
        var cliente: String
        var linea: String
        var strURL: String  = "http://wscibertec2021.somee.com/Servicio/RegistraModifica?"
        var strParametro: String
        
        cliente = tfCliente.text!
        linea = tfLinea.text!
        cliente = cliente.replacingOccurrences(of: " ", with: "%20")
        linea = linea.replacingOccurrences(of: " ", with: "%20")
        
        strParametro = "Accion=" + self.ACCION
        strParametro += "&CodigoServicio=" + tfCodigo.text!
        strParametro += "&NombreCliente=" + cliente + tfCliente.text!
        strParametro += "&NumeroOrdenServicio=" + tfOrden.text!
        strParametro += "&Fechaprogramada=" + tfFecha.text!
        strParametro += "&Linea=" + linea + tfLinea.text!
        strParametro += "&Estado=" + tfEstado.text!
        strParametro += "&Observaciones=" + tfObs.text!
        
        let purl = strURL + strParametro
        let objURL = URL(string: purl)
        var objRequest = URLRequest(url: objURL!)
        
        objRequest.httpMethod = "GET"
        objRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let oTarea = URLSession.shared.dataTask(with: objRequest){ Datos, Response, Error in
            DispatchQueue.main.async {
                if Error == nil
                {
                    let JSON = try? JSONSerialization.jsonObject(with: Datos!, options: [])
                        if let objUsuario = JSON as? [String: Any]
                        {
                            var straCodigoServicio: Int = objUsuario["CodigoServicio"] as! Int
                            if (straCodigoServicio > 0) {
                                self.tfCodigo.text = String(straCodigoServicio)
                                self.ACCION = "A"
                                self.lblMensaje.text = "Grabado Correcatamente"
                            }
                            else{
                                self.lblMensaje.text = "Error al grabar: \(Error.debugDescription)"
                            }
                        }
                    
                }
            }
            
        }
        
        oTarea.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

//
//  ViewController.swift
//  Examen3
//
//  Created by Renzo on 22/06/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,
                      UITableViewDelegate{
    
    @IBOutlet weak var tvTablaVista: UITableView!
    @IBOutlet weak var tfCliente: UITextField!
    @IBOutlet weak var tfCodigo: UITextField!
    @IBOutlet weak var lblMensaje: UILabel!
    
    var oListaUser: [Usuario_BE] = [Usuario_BE]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvTablaVista.delegate = self
        tvTablaVista.dataSource = self
        tvTablaVista.rowHeight = 150
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oListaUser.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let oCelda = tableView.dequeueReusableCell(withIdentifier: "CeldaUser", for: indexPath) as! TableViewCellCeldaUser
        oCelda.CargarDatos(pUsuario: oListaUser[indexPath.row])
        return oCelda
        
    }
    
    
    @IBAction func btnBuscar(_ sender: UIButton) {
        
        var cliente: String
        var codigo: String
        
        cliente = tfCliente.text!
        codigo = tfCodigo.text!
        cliente = cliente.replacingOccurrences(of: " ", with: "%20")
        codigo = codigo.replacingOccurrences(of: " ", with: "%20")
        
        var strlUrl: String = "http://wscibertec2021.somee.com/Servicio/Listar?NombreCliente=" + cliente
        var oURL = URL(string: strlUrl)
        let oPeticion = URLRequest(url: oURL!)
        
        oListaUser.removeAll()
        
        let oTarea = URLSession.shared.dataTask(with: oPeticion){ Datos, Respuesta, Error in
        
            DispatchQueue.main.async {
                if (Error == nil)
                {
                    let JSON = try? JSONSerialization.jsonObject(with: Datos!, options: [])
                    
                    if  //let oDiccionario = JSON as? [String: Any],
                        //let oListaUser = oDiccionario as? [[String: Any]]
                        let oListaUser = JSON as? [[String: Any]]
                    {
                        oListaUser.forEach(){ oRegistro in
                            
                            var oUsuario_BE: Usuario_BE = Usuario_BE()
                            oUsuario_BE.Nombre = oRegistro ["NombreCliente"] as! String
                            oUsuario_BE.NumeroOrden = oRegistro ["NumeroOrdenServicio"] as! String
                            oUsuario_BE.Fecha = oRegistro["FechaProgramada"] as! String
                            
                            self.oListaUser.append(oUsuario_BE)
                            
                        }
                        self.tvTablaVista.reloadData()
                    }
                    
                }
                else{
                    self.lblMensaje.text = "\(Error.debugDescription)"
                }
            }
            
        }
        oTarea.resume()
    }
}


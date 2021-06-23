//
//  TableViewCellCeldaUser.swift
//  Examen3
//
//  Created by Renzo on 22/06/21.
//

import UIKit

class TableViewCellCeldaUser: UITableViewCell {

    @IBOutlet weak var lblNroOrden: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblCliente: UILabel!
    
    var oUsuario: Usuario_BE = Usuario_BE()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func CargarDatos(pUsuario: Usuario_BE){
        
        lblNroOrden.text = pUsuario.NumeroOrden
        lblFecha.text = pUsuario.Fecha
        lblCliente.text = pUsuario.Nombre
        oUsuario = pUsuario
    }
}

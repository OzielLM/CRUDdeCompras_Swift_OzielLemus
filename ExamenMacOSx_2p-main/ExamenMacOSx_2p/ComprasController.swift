//
//  ComprasController.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 18/05/23.
//

import Foundation

class ComprasController{
    @objc dynamic var compras:[Compra]=[]
    static var compartir: ComprasController = {
        let instance = ComprasController()
        return instance
    }()
    
    func addCompra(_ compra:Compra){
        compras.append(compra)
    }
}

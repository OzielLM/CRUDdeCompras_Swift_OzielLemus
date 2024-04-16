//
//  VentasController.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 20/05/23.
//

import Foundation

class VentasController{
    @objc dynamic var ventas:[Venta]=[]
    static var compartir: VentasController = {
        let instance = VentasController()
        return instance
    }()
    
    func addVenta(_ venta:Venta){
        ventas.append(venta)
    }
}

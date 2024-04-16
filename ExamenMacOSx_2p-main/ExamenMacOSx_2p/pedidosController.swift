//
//  pedidosController.swift
//  ExamenMacOSx_2p
//
//  Created by Adriana MV on 20/05/23.
//

import Foundation

class pedidosController{
    @objc dynamic var pedidos:[Pedidos] = []
    static var compartir: pedidosController = {
        let instance = pedidosController()
        return instance
    }()
    
    func addPedido(_ pedido:Pedidos){
        pedidos.append(pedido)
    }
}

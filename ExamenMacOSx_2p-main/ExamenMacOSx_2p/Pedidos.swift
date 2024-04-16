//
//  Pedidos.swift
//  ExamenMacOSx_2p
//
//  Created by Adriana MV on 20/05/23.
//

import Foundation

class Pedidos: NSObject{
    @objc dynamic var id:Int
    @objc dynamic var idProducto:Int
    @objc dynamic var nombreProducto:String //
    @objc dynamic var descripcionProducto:String //
    @objc dynamic var unidadProducto:String //
    @objc dynamic var precioProducto:Double //
    @objc dynamic var costoProducto:Double //
    @objc dynamic var categoriaProducto:String //
    @objc dynamic var cantidadPedidaProducto:Int
    @objc dynamic var totalDePedido:Double
    static var contador = 0
    
    init(_ idProducto: Int,_ nombreProducto: String,_ descripcionProducto: String,_ unidadProducto: String,_ precioProducto: Double,_ costoProducto: Double,_ categoríaProducto: String,_ cantidadPedidaProducto: Int, _ totalDePedido: Double) {
        self.id = Pedidos.contador
        Pedidos.contador += 1
        self.idProducto = idProducto
        self.nombreProducto = nombreProducto
        self.descripcionProducto = descripcionProducto
        self.unidadProducto = unidadProducto
        self.precioProducto = precioProducto
        self.costoProducto = costoProducto
        self.categoriaProducto = categoríaProducto
        self.cantidadPedidaProducto = cantidadPedidaProducto
        self.totalDePedido = totalDePedido
    }
}

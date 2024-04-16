//
//  Ventas.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 20/05/23.
//

import Foundation

class Venta: NSObject{
    @objc dynamic var idVenta:Int
    
    
    @objc dynamic var idProducto:Int
    @objc dynamic var nombreProducto:String // nombreProducto
    @objc dynamic var descripcionProducto:String //
    @objc dynamic var unidadProducto:String //
    @objc dynamic var precioProducto:Double //
    @objc dynamic var categoríaProducto:String //
    @objc dynamic var cantidadVenta:Int //
    
    @objc dynamic var nombreVendedor:String //
    @objc dynamic var apellidoPVendedor:String //
    @objc dynamic var apellidoMVendedor:String//
    @objc dynamic var emailVendedor:String //
    @objc dynamic var telefonoVendedor:String
    
    @objc dynamic var idCliente:Int
    @objc dynamic var nombreCliente:String//
    @objc dynamic var apellidoPCliente:String
    @objc dynamic var apellidoMCliente:String
    @objc dynamic var correoCliente:String
    @objc dynamic var telefonoCliente:String
    
    @objc dynamic var subtotal:Double
    @objc dynamic var IVA:Double
    @objc dynamic var total:Double
    static var contador:Int = 0
    
    init(_ idProducto: Int,_ nombreProducto: String,_ descripcionProducto: String,_ unidadProducto: String,_ precioProducto: Double,_ categoríaProducto: String,_ cantidadVenta: Int,_ nombreVendedor: String,_ apellidoPVendedor: String,_ apellidoMVendedor: String,_ emailVendedor: String,_ telefonoVendedor: String,_ idCliente: Int,_ nombreCliente: String,_ apellidoPCliente: String,_ apellidoMCliente: String,_ correoCliente: String,_ telefonoCliente: String,_ subtotal: Double,_ IVA: Double,_ total: Double) {
        self.idVenta = Venta.contador
        Venta.contador += 1
        self.idProducto = idProducto
        self.nombreProducto = nombreProducto
        self.descripcionProducto = descripcionProducto
        self.unidadProducto = unidadProducto
        self.precioProducto = precioProducto
        self.categoríaProducto = categoríaProducto
        self.cantidadVenta = cantidadVenta
        self.nombreVendedor = nombreVendedor
        self.apellidoPVendedor = apellidoPVendedor
        self.apellidoMVendedor = apellidoMVendedor
        self.emailVendedor = emailVendedor
        self.telefonoVendedor = telefonoVendedor
        self.idCliente = idCliente
        self.nombreCliente = nombreCliente
        self.apellidoPCliente = apellidoPCliente
        self.apellidoMCliente = apellidoMCliente
        self.correoCliente = correoCliente
        self.telefonoCliente = telefonoCliente
        self.subtotal = subtotal
        self.IVA = IVA
        self.total = total
    }
}

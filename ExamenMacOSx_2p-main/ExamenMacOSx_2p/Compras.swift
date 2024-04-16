//
//  Compras.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 18/05/23.
//

import Foundation

class Compra: NSObject{

    @objc dynamic var id:Int
    @objc dynamic var idProducto:Int
    @objc dynamic var cantidad:Int
    @objc dynamic var idComprador:Int
    @objc dynamic var nombre:String // nombreProducto
    @objc dynamic var descripcion:String //
    @objc dynamic var unidad:String //
    @objc dynamic var precio:Double //
    @objc dynamic var costo:Double //
    @objc dynamic var categoría:String //
    @objc dynamic var cantidadProducto:Int //
    @objc dynamic var username:String //
    //@objc dynamic var nombreUser:String //
    @objc dynamic var apellidoP:String //
    @objc dynamic var apellidoM:String//
    @objc dynamic var email:String //
    @objc dynamic var telefono:String //
    static var contador = 0

    
    init( _ idProducto: Int, _ cantidad: Int, _ idComprador: Int, _ nombre: String, _ descripcion: String, _ unidad: String, _ precio: Double, _ costo: Double, _ categoría: String, _ cantidadProducto: Int, _ username: String,  _ apellidoP: String, _ apellidoM: String, _ email: String, _ telefono: String) {
        self.id = Compra.contador
        Compra.contador += 1
        self.idProducto = idProducto
        self.cantidad = cantidad
        self.idComprador = idComprador
        self.nombre = nombre
        self.descripcion = descripcion
        self.unidad = unidad
        self.precio = precio
        self.costo = costo
        self.categoría = categoría
        self.cantidadProducto = cantidadProducto
        self.username = username
        //self.nombreUser = nombreUser
        self.apellidoP = apellidoP
        self.apellidoM = apellidoM
        self.email = email
        self.telefono = telefono
    }
  
    
}

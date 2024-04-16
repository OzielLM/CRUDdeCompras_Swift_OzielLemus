//
//  Productos.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 16/05/23.
//

import Foundation

class Product: NSObject{
    
    @objc dynamic var id:Int
    @objc dynamic var nombre:String //
    @objc dynamic var descripcion:String //
    @objc dynamic var unidad:String //
    @objc dynamic var precio:Double //
    @objc dynamic var costo:Double //
    @objc dynamic var categoría:String //
    @objc dynamic var cantidad:Int //
    static var contador = 0
    
    init(_ nombre: String,_ descripcion: String,_ unidad: String,_ precio: Double,_ costo: Double,_ categoría: String,_ cantidad: Int) {
        self.id = Product.contador
        Product.contador += 1
        self.nombre = nombre
        self.descripcion = descripcion
        self.unidad = unidad
        self.precio = precio
        self.costo = costo
        self.categoría = categoría
        self.cantidad = cantidad
    }
}

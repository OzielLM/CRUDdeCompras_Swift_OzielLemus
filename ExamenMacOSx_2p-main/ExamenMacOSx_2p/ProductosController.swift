//
//  ProductosController.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 16/05/23.
//

import Foundation

class ProductosController{
    @objc dynamic var productos:[Product] = []
    static var compartir: ProductosController = {
        let instance = ProductosController()
        return instance
    }()
    
    func addProduct(_ product:Product){
        productos.append(product)
    }
}

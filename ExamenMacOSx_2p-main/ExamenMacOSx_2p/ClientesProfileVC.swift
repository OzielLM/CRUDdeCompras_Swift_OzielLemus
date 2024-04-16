//
//  ClientesProfileVC.swift
//  ExamenMacOSx_2p
//
//  Created by Adriana MV on 20/05/23.
//

import Cocoa

class ClientesProfileVC: NSViewController {

    var usuarioRecibido:String?
    var mensaje:String?
    
    var loginController = LoginController.compartir
    var ventasController = VentasController.compartir
    var PedidosController = pedidosController.compartir
    var color1:NSColor?
    var idCliente:Int = 0
    
    func asignarColor(_ color:String){
        switch color {
        case "verde":
            color1 = NSColor.green
        case "rojo":
            color1 = NSColor.red
        case "azul":
            color1 = NSColor.blue
        case "amarillo":
            color1 = NSColor.yellow
        case "naranja":
            color1 = NSColor.orange
        case "ninguno":
            color1 = NSColor.white
        default:
            break
        }
    }
    
    
    func setValue(){
        
        
        for x in 0...loginController.users.count-1{
            if usuarioRecibido==loginController.users[x].username{
                img.image=NSImage(named: loginController.users[x].imagen)
                asignarColor(loginController.users[x].fondo)
                view.wantsLayer = true
                view.layer?.backgroundColor=color1?.cgColor
            }
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        lblMensajeBienvenida.stringValue = mensaje!
        setValue()
        obtenerElIdClienteDelUsuarioRecibido()
    }
    
    @IBAction func viajarATablaProductos(_ sender: Any) {
        asignarVentasAlArregloPedidos()
        performSegue(withIdentifier: "irATablaPedidos", sender: self)
    }
    
    @IBAction func salirDeLaPagina(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    func obtenerElIdClienteDelUsuarioRecibido(){
        for x in 0...loginController.users.count-1{
            if usuarioRecibido == loginController.users[x].username{
                idCliente = loginController.users[x].id
            }
        }
    }
    
    func asignarVentasAlArregloPedidos(){
        PedidosController.pedidos.removeAll()
        if ventasController.ventas.isEmpty == false{
            for x in 0...ventasController.ventas.count-1{
                if idCliente == 0{
                    PedidosController.addPedido(Pedidos(ventasController.ventas[x].idProducto, ventasController.ventas[x].nombreProducto, ventasController.ventas[x].descripcionProducto, ventasController.ventas[x].unidadProducto, ventasController.ventas[x].precioProducto, ventasController.ventas[x].total, ventasController.ventas[x].categoríaProducto, ventasController.ventas[x].cantidadVenta, ventasController.ventas[x].total))
                }else{
                    if idCliente == ventasController.ventas[x].idCliente{
                        PedidosController.addPedido(Pedidos(ventasController.ventas[x].idProducto, ventasController.ventas[x].nombreProducto, ventasController.ventas[x].descripcionProducto, ventasController.ventas[x].unidadProducto, ventasController.ventas[x].precioProducto, ventasController.ventas[x].total, ventasController.ventas[x].categoríaProducto, ventasController.ventas[x].cantidadVenta, ventasController.ventas[x].total))
                    }
                }
            }
        }else{
            alertaArregloVentasVacio()
        }
    }
    
    func alertaArregloVentasVacio() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "No hay Ventas Hasta el Momento"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "irATablaPedidos"{
            let destination = segue.destinationController as! TablaPedidosVC
            destination.pedidos = PedidosController.pedidos
            destination.usuarioRecibido = self.usuarioRecibido
        }
    }
    
    @IBOutlet weak var lblMensajeBienvenida: NSTextField!
    @IBOutlet weak var btnConsultarPedidos: NSButton!
    @IBOutlet weak var btnSalir: NSButton!
    
    
    @IBOutlet weak var img: NSImageCell!
}

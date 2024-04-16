//
//  CRUDVentasVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 21/05/23.
//

import Cocoa

class CRUDVentasVC: NSViewController {
    var usuarioRecibido:String?
    var usuario: String = ""
    var id :Int = 0
    var enviarAFlag: Bool = false
    var ventasController = VentasController.compartir
    var productosController = ProductosController.compartir
    var loginController = LoginController.compartir
    var sumaCantidad: Int = 0
    var color1:NSColor?
    
    
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
    //var restaCantidad: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
        usuario = usuarioRecibido!
        lblID.isHidden=true
        txtID.isHidden=true
        btnOK.isHidden=true
        btnEliminar.isHidden=true
        // Do view setup here.
    }
    @IBOutlet weak var btnVolver: NSButton!
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var btnAlta: NSButton!
    @IBOutlet weak var btnBaja: NSButton!
    @IBOutlet weak var btnModificar: NSButton!
    @IBOutlet weak var btnConsulta: NSButton!
    @IBOutlet weak var lblID: NSTextField!
    @IBOutlet weak var btnOK: NSButton!
    @IBOutlet weak var btnEliminar: NSButton!
    
    @IBOutlet weak var img: NSImageCell!
    
    @IBAction func volver(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    @IBAction func altaCompra(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    
    @IBAction func actualizarCompra(_ sender: Any) {
        if validacionID(){
            for x in 0...ventasController.ventas.count-1{
                if(Int(txtID.stringValue) == ventasController.ventas[x].idVenta){
                    id = x
                }
            }
            enviarAFlag = true
            performSegue(withIdentifier: "actualizarVenta", sender: self)
            dismiss(self)
        }else{
            alertaValidacion()
        }
        
        
    }

    
    @IBAction func modificar(_ sender: Any) {
        lblID.isHidden=false
        txtID.isHidden=false
        btnOK.isHidden=false
        btnEliminar.isHidden=true
    }
    
    
     @IBAction func eliminar(_ sender: Any) {
         if validacionID(){
             if(!ventasController.ventas.isEmpty){
                 sumaCantidad = productosController.productos[ventasController.ventas[Int(txtID.intValue)].idProducto].cantidad + ventasController.ventas[Int(txtID.intValue)].cantidadVenta
                 productosController.productos[ventasController.ventas[Int(txtID.intValue)].idProducto].cantidad = sumaCantidad
                 for x in 0...ventasController.ventas.count-1{
                     if(Int(txtID.stringValue) == ventasController.ventas[x].idVenta){
                         ventasController.ventas.remove(at: x)
                         break
                     }
                 }
                 alerta()
                 txtID.stringValue = ""
                 
             }else{
                 alertaNoEliminar()
             }
         }else{
             alertaValidacion()
         }
         
         
     }
     
    

    @IBAction func Consulta(_ sender: Any) {
        performSegue(withIdentifier: "irATablaVenta", sender: self)
    }
    
    @IBAction func funcBaja(_ sender: Any) {
        txtID.isHidden = false
        lblID.isHidden = false
        btnEliminar.isHidden = false
        btnOK.isHidden = true
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if(segue.identifier == "actualizarVenta"){
            let destinationVC = segue.destinationController as! VentasProfileVC
            destinationVC.flag = enviarAFlag
            destinationVC.posicion = id
            destinationVC.usuarioRecibido = usuario
        }
        
        if(segue.identifier == "irATablaVenta"){
            let destinationViewCont = segue.destinationController as! TablaVentas
            destinationViewCont.ventas = ventasController.ventas
            destinationViewCont.usuarioRecibido = self.usuarioRecibido
        }
        if(segue.identifier == "altaVenta"){
            let destinationVC = segue.destinationController as! VentasProfileVC
            enviarAFlag = false
            destinationVC.flag = enviarAFlag
            destinationVC.posicion = id
            destinationVC.usuarioRecibido = usuario
        }
        
    }
    
    
    func alertaNoEliminar() -> Bool{
        let alert: NSAlert = NSAlert()
        alert.messageText = "El arreglo esta vacío, ingresa otra venta"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    func alerta() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Venta eliminada"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func validacionID() -> Bool {
        var estado = false
        if !ventasController.ventas.isEmpty{
            for venta in ventasController.ventas{
                if(txtID.integerValue == venta.idVenta){
                    estado = true
                }
            }
        }else{
            estado = false
        }
        return estado
    }
    
    func alertaValidacion() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "No existe el ID, verifica en la lista de ventas los ID"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
}

//
//  CRUDComprasVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 18/05/23.
//

import Cocoa

class CRUDComprasVC: NSViewController {
    var usuarioRecibido:String?
    var usuario: String = ""
    var id :Int = 0
    var enviarAFlag: Bool = false
    var compraController = ComprasController.compartir
    var productosController = ProductosController.compartir
    var restaCantidad: Int = 0
    var color1:NSColor?
    var loginController = LoginController.compartir
    
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
        usuario = usuarioRecibido!
        setValue()
        lblID.isHidden=true
        txtID.isHidden=true
        btnOK.isHidden=true
        btnEliminar.isHidden=true
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
            for x in 0...compraController.compras.count-1{
                if(txtID.integerValue == compraController.compras[x].id){
                    id = x
                }
            }
            enviarAFlag = true
            performSegue(withIdentifier: "actualizarCompra", sender: self)
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
            if(!compraController.compras.isEmpty){
                restaCantidad = productosController.productos[compraController.compras[Int(txtID.intValue)].idProducto].cantidad - compraController.compras[Int(txtID.intValue)].cantidad
                productosController.productos[compraController.compras[Int(txtID.intValue)].idProducto].cantidad = restaCantidad
                for x in 0...compraController.compras.count-1{
                    if(txtID.integerValue == compraController.compras[x].id){
                        compraController.compras.remove(at: x)
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
    
    
    @IBAction func funcBaja(_ sender: Any) {
        txtID.isHidden = false
        lblID.isHidden = false
        btnEliminar.isHidden = false
        btnOK.isHidden = true
    }
    
    
    
    @IBAction func Consulta(_ sender: Any) {
        performSegue(withIdentifier: "mostrar", sender: self)
    }
   
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if(segue.identifier == "actualizarCompra"){
            let destinationVC = segue.destinationController as! ComprasProfileVC
            destinationVC.flag = enviarAFlag
            destinationVC.posicion = id
            destinationVC.usuarioRecibido = usuario
        }
        if(segue.identifier == "mostrar"){
            let destinationViewCont = segue.destinationController as! TablaCompra
            destinationViewCont.compras = compraController.compras
            destinationViewCont.prueba = "mensaje"
            destinationViewCont.usuarioRecibido = self.usuarioRecibido
        }
        if(segue.identifier == "altaCompra"){
            let destinationVC = segue.destinationController as! ComprasProfileVC
            enviarAFlag = false
            destinationVC.flag = enviarAFlag
            destinationVC.posicion = id
            destinationVC.usuarioRecibido = usuario
        }
        
    }

    
    
    
    func alertaNoEliminar() -> Bool{
        let alert: NSAlert = NSAlert()
        alert.messageText = "El arreglo esta vacío, ingresa otra compra"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    func alerta() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Compra eliminada"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func validacionID() -> Bool {
        var estado = false
        if !compraController.compras.isEmpty{
            for compra in compraController.compras{
                if(txtID.integerValue == compra.id){
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
        alert.messageText = "No existe el ID, verifica en la lista de compras los ID"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    
}

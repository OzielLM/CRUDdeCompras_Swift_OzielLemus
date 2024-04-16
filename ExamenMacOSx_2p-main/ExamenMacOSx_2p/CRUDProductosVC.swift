//
//  CRUDProductosVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 16/05/23.
//

import Cocoa

class CRUDProductosVC: NSViewController {

    var id:Int = 0
    var enviarAFlag: Bool = false
    var productoController = ProductosController.compartir
    var usuarioRecibido:String?
    var usuario: String = ""
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
        lblID.isHidden = true
        txtID.isHidden = true
        btnOK.isHidden = true
        btnEliminar.isHidden = true
        usuario = usuarioRecibido!
        setValue()
    }
    
    @IBOutlet weak var lblMensage: NSTextField!
    @IBOutlet weak var btnCerrarSesion: NSButton!    
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
    
    @IBAction func altaProducto(_ sender: Any) {
        performSegue(withIdentifier: "crearProducto", sender: self)
        self.view.window?.windowController?.close()
    }
    
    @IBAction func actualizarProducto(_ sender: Any) {
        if validacionID(){
            for x in 0...productoController.productos.count-1{
                if(txtID.integerValue == productoController.productos[x].id){
                    id = x
                }
            }
            enviarAFlag = true
            performSegue(withIdentifier: "actualizarProducto", sender: self)
            dismiss(self)
        }else{
            alertaValidacion()
        }
        
        
    }
    
    @IBAction func modificar(_ sender: Any) {
        txtID.isHidden = false
        lblID.isHidden = false
        btnOK.isHidden = false
        btnEliminar.isHidden = true
        
    }
    
    @IBAction func eliminar(_ sender: Any) {
        if validacionID(){
            for x in 0...productoController.productos.count-1{
                if(txtID.integerValue == productoController.productos[x].id){
                    productoController.productos.remove(at: x)
                    break
                }
            }
            alerta()
            txtID.stringValue = ""
        }else{
            alertaValidacion()
        }
        
    }
    
    func alerta() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Producto eliminado"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func alertaNoEliminar() -> Bool{
        let alert: NSAlert = NSAlert()
        alert.messageText = "El arreglo esta vacío, ingresa otro producto"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    @IBAction func funcionEliminar(_ sender: Any) {
        txtID.isHidden = false
        lblID.isHidden = false
        btnEliminar.isHidden = false
        btnOK.isHidden = true
        
    }
    
    @IBAction func mostrarTabla(_ sender: Any) {
        performSegue(withIdentifier: "mostrar", sender: self)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if(segue.identifier == "actualizarProducto"){
            let destinationVC = segue.destinationController as! ProductosProfileVC
            destinationVC.flag = enviarAFlag
            destinationVC.posicion = id
            destinationVC.usuarioRecibido2 = usuario
        }
        
        if(segue.identifier == "crearProducto"){
            let destinationVC = segue.destinationController as! ProductosProfileVC
            destinationVC.flag = enviarAFlag
            destinationVC.posicion = id
            destinationVC.usuarioRecibido2 = usuario
        }
        
        
        if(segue.identifier == "mostrar"){
            let destinationViewCont = segue.destinationController as! Tablap
            destinationViewCont.products = productoController.productos
            destinationViewCont.prueba = "mensaje"
            destinationViewCont.usuarioRecibido = self.usuarioRecibido
        }
         
         
    }
    
    func validacionID() -> Bool {
        var estado = false
        if !productoController.productos.isEmpty{
            for producto in productoController.productos{
                if(txtID.integerValue == producto.id){
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
        alert.messageText = "No existe el ID, verifica en la lista de productos los ID"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }

}

//
//  LoginVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 13/05/23.
//

import Cocoa

class LoginVC: NSViewController {
    var usuarioRecibido:String?
    var color1:NSColor?
    var id:Int = 0
    var enviarAFlag: Bool = false
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
    
    @IBAction func cerrarSesion(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    @IBAction func crearUsuarioPorAdmin(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    
    @IBAction func actualizar(_ sender: Any) {
        //Oziel: Cambiar parametros para enviarlos
        
        if validacionID() {
            if Int(txtID.intValue) == 0{
                alertaNoEliminar()
            }else{
                for x in 0...loginController.users.count-1{
                    if(Int(txtID.stringValue) == loginController.users[x].id){
                        id = x
                    }
                }
                enviarAFlag = true
                performSegue(withIdentifier: "actualizarUsuario", sender: self)
                dismiss(self)
            }
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
            if(Int(txtID.intValue) == 0){
                alertaNoEliminar()
            }else{
                for x in 0...loginController.users.count-1{
                    if(Int(txtID.stringValue) == loginController.users[x].id){
                        loginController.users.remove(at: x)
                        break
                    }
                }
                alerta()
                txtID.stringValue = ""
            }
        }else{
            alertaValidacion()
        }
        
        
        
    }
    
    func alerta() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Usuario eliminado"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func alertaNoEliminar() -> Bool{
        let alert: NSAlert = NSAlert()
        alert.messageText = "No se puede eliminar ni modificar al Usuario 0"
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
    //Oziel: Crear funcion prepare
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if(segue.identifier == "actualizarUsuario"){
            let destinationVC = segue.destinationController as! AdminProfileVC
            destinationVC.flag = enviarAFlag
            destinationVC.posicion = id
        }
        
        
        if(segue.identifier == "mostrar"){
            let destinationViewCont = segue.destinationController as! Tabla
            destinationViewCont.users = loginController.users
            destinationViewCont.prueba = "mensaje"
            destinationViewCont.usuarioRecibido = self.usuarioRecibido
        }
         
    }
    
    func validacionID() -> Bool {
        var estado = false
        if !loginController.users.isEmpty{
            for user in loginController.users{
                if(Int(txtID.stringValue) == user.id){
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
        alert.messageText = "No existe el ID, verifica en la lista de usuarios los ID"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    
}


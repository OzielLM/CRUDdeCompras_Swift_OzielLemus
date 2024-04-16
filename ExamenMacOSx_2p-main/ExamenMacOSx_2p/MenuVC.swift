//
//  MenuVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 16/05/23.
//

import Cocoa

class MenuVC: NSViewController {
    var destinoMensage:String?
    var usuarioRecibido:String?
    var loginController = LoginController.compartir
    var usuario: String = ""
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usuario = usuarioRecibido!
        lblMensaje.stringValue = destinoMensage!
        validarMenu()
        setValue()
    }
    
    func validarMenu(){
        if destinoMensage!.contains("Admin"){
            btnUsuarios.isHidden = false
            btnVentas.isHidden = false
            btnCompras.isHidden = false
            btnClientes.isHidden = false
        }else{
            if destinoMensage!.contains("Cliente"){
                btnUsuarios.isHidden = true
                btnVentas.isHidden = true
                btnCompras.isHidden = true
                btnClientes.isHidden = false
            }else{
                if destinoMensage!.contains("Vendedor"){
                    btnVentas.isHidden = false
                    btnCompras.isHidden = true
                    btnUsuarios.isHidden = true
                    btnClientes.isHidden = true
                }else{
                    if destinoMensage!.contains("Compras"){
                        btnVentas.isHidden = true
                        btnCompras.isHidden = false
                        btnClientes.isHidden = true
                        btnUsuarios.isHidden = true
                    }
                    else{
                        btnUsuarios.isHidden = true
                        btnVentas.isHidden = true
                        btnCompras.isHidden = true
                        btnClientes.isHidden = true
                        btnCerrarSesion.title = "Volver"
                    }

                }
            }
            
        }
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {

        if segue.identifier == "compras" {
            let destination = segue.destinationController as! OpcionesCompradorVC
            destination.usuarioRecibido = usuario
        }
        
        if segue.identifier == "irAPedidos"{
            let destination = segue.destinationController as! ClientesProfileVC
            destination.usuarioRecibido = usuario
            destination.mensaje = destinoMensage
        }
        if segue.identifier == "irAVentas"{
            let destination = segue.destinationController as! CRUDVentasVC
            destination.usuarioRecibido = usuario
        }
        
        if segue.identifier == "irAUsuarios"{
            let destination = segue.destinationController as! LoginVC
            destination.usuarioRecibido = self.usuario
        }

    }
    
    @IBOutlet weak var lblMensaje: NSTextField!
    @IBOutlet weak var btnUsuarios: NSButton!
    @IBOutlet weak var btnVentas: NSButton!
    @IBOutlet weak var btnCompras: NSButton!
    @IBOutlet weak var btnClientes: NSButton!
    @IBOutlet weak var btnCerrarSesion: NSButton!
    
    @IBOutlet weak var img: NSImageCell!
    
}

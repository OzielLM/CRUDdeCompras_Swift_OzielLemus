//
//  OpcionesCompradorVC.swift
//  ExamenMacOSx_2p
//
//  Created by Moises Hernandez Alvarado on 18/05/23.
//

import Cocoa

class OpcionesCompradorVC: NSViewController {
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
        usuario = usuarioRecibido!
        setValue()
        // Do view setup here.
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {

        if segue.identifier == "compras" {
            let destination = segue.destinationController as! CRUDComprasVC
            destination.usuarioRecibido = usuario
        }
        
        if segue.identifier == "productos" {
            let destination = segue.destinationController as! CRUDProductosVC
            destination.usuarioRecibido = usuario
        }
    }
    
    @IBOutlet weak var img: NSImageCell!
    
}

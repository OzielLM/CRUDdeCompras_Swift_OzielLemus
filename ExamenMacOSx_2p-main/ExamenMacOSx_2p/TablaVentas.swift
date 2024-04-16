//
//  TablaVentas.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 22/05/23.
//

import Cocoa

class TablaVentas: NSViewController {
    
    
    
    
    @objc dynamic var ventas:[Venta] = []

    
    var loginController = LoginController.compartir
    var usuarioRecibido:String?
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
    
    
    @IBOutlet weak var img: NSImageView!
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
        setValue()
    }
    
}

//
//  ViewController.swift
//  ExamenMacOSx_2p
//
//  Created by Moises Hernandez Alvarado on 11/05/23.
//

import Cocoa

class ViewController: NSViewController {
    var username: String = ""
    var password: String = ""
    var mensaje: String = ""
    var usuario: String = ""
    var loginController = LoginController.compartir
    var posicion:Int?
    var productosController = ProductosController.compartir

    override func viewDidLoad() {
        super.viewDidLoad()
        loginController.addUser(User("admin", "admin123", "Admin", "Super", "MOM", "your@mom.cum", "4771234567", "admin", 4,0,Date.now,"ninguno","ninguno"))
        

        // Do any additional setup after loading the view.
    }
    
    func login() {
        username = txtUser.stringValue
        password = txtPassword.stringValue
                
        let loginResult = loginController.login(username: username, password: password)
        
        for x in 0...loginController.users.count-1{
            if(loginController.users[x].username == username){
                usuario = username
                posicion = x
            }
        }
        
        if loginResult {
            if txtUser.stringValue == "admin" {
                mensaje = "Bienvenido \(username) Admin"
            }else{
                
                switch(loginController.users[posicion!].role){
                case 1: mensaje = "Bienvenido \(username) Cliente"
                    break
                case 2: mensaje = "Bienvenido \(username) Vendedor"
                    break
                case 3: mensaje = "Bienvenido \(username) Compras"
                    break
                    /*
                case 4: mensaje = "Bienvenido \(username) Admin"
                    break
                     */
                default: mensaje = "Bienvenido \(username) Rol no defenido aún"
                    break
                }
            }
        } else {
            mensaje = "Usuario y/o contraseña incorrecto(s)"
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        login()
        if segue.identifier == "irAMenu" {
            let destination = segue.destinationController as! MenuVC
            destination.destinoMensage = mensaje
            destination.usuarioRecibido = usuario
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var txtUser: NSTextField!
    @IBOutlet weak var txtPassword: NSSecureTextField!
    @IBOutlet weak var btnRegistrar: NSButton!
    @IBOutlet weak var btnIniciarSesion: NSButton!
    

}


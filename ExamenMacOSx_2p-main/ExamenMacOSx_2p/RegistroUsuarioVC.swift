//
//  RegistroUsuarioVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 13/05/23.
//

import Cocoa

class RegistroUsuarioVC: NSViewController, NSComboBoxDelegate, NSComboBoxDataSource {
    var mensaje : String = ""
    var loginController = LoginController.compartir
    var rol:String?
    var contadorID = User.contador
    
    var color1=""
    var imagen1=""
    
    
    let colores=["rojo","azul","verde","amarillo","naranja","ninguno"]
    
    let imagen=["redAzul","olaAzul","marcoRosa","arcoNaranja","arcoAzul","ninguno"]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        txtId.isEnabled = false
        txtId.stringValue = String(contadorID)
        
        cmbImg.delegate = self
        cmbColor.delegate = self
        cmbImg.dataSource=self
        cmbColor.dataSource=self
        
        
        for color in colores {
            cmbColor.addItem(withObjectValue: color)
        }
        
        for img in imagen {
            cmbImg.addItem(withObjectValue: img)
        }
    }
    
    func registro (){
        imagen1 = cmbImg.stringValue
        color1=cmbColor.stringValue
        loginController.addUser(User(txtUserName.stringValue, txtPassword.stringValue, txtNombre.stringValue, txtApellidoP.stringValue, txtApellidoM.stringValue, txtEmail.stringValue, txtTelefono.stringValue, txtGenero.stringValue, 0,calcularEdad(dateNacimiento),dateNacimiento.dateValue,color1,imagen1))
            login()
    }
    
    func login() {
        let username = txtUserName.stringValue
        let password = txtPassword.stringValue
        
        let loginResult = loginController.login(username: username, password: password)
        
        if loginResult {
            if rol == nil{
                mensaje = "Bienvenido \(username) Rol no defenido aún"
            }else{
                mensaje = "Bienvenido \(username) \(rol!)"
            }
            
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        registro()
        if segue.identifier == "irAMenu" {
            let destination = segue.destinationController as! MenuVC
            destination.usuarioRecibido = txtUserName.stringValue
            destination.destinoMensage = mensaje
        }
    }
    
    @IBOutlet weak var txtUserName: NSTextField!
    @IBOutlet weak var txtPassword: NSSecureTextField!
    @IBOutlet weak var txtConfirmarPassword: NSSecureTextField!
    @IBOutlet weak var lblConfirmarPassword: NSTextField!
    @IBOutlet weak var txtId: NSTextField!
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtApellidoP: NSTextField!
    @IBOutlet weak var txtApellidoM: NSTextField!
    @IBOutlet weak var txtTelefono: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtGenero: NSComboBox!
    @IBOutlet weak var dateNacimiento: NSDatePicker!
    @IBOutlet weak var cmbColor: NSComboBox!
    @IBOutlet weak var cmbImg: NSComboBox!
    
    
    func calcularEdad(_ datePicker: NSDatePicker) -> Int {
        let birthDate = datePicker.dateValue
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        let age = ageComponents.year!
        
        return age
    }
    
    @IBAction func checarContraseña(_ sender: NSButton) {
        if txtUserName.stringValue == "" || txtPassword.stringValue == "" || txtConfirmarPassword.stringValue == "" || txtNombre.stringValue == "" || txtApellidoP.stringValue == "" || txtApellidoM.stringValue == "" || txtTelefono.stringValue == "" || txtEmail.stringValue == "" || txtGenero.stringValue == "" || cmbColor.stringValue == "" || cmbImg.stringValue == "" || txtNombre.stringValue.range(of: "[0-9]", options: .regularExpression) != nil || txtApellidoP.stringValue.range(of: "[0-9]", options: .regularExpression) != nil || txtApellidoM.stringValue.range(of: "[0-9]", options: .regularExpression) != nil || !txtEmail.stringValue.contains("@") || txtPassword.stringValue.count < 8 || txtConfirmarPassword.stringValue.count < 8 || txtTelefono.stringValue.count != 10 || txtTelefono.stringValue.range(of: "[a-z]", options: .regularExpression) != nil{
            alerta()
        }else{
            if txtPassword.stringValue == txtConfirmarPassword.stringValue {
                performSegue(withIdentifier: "irAMenu", sender: self)
                txtPassword.stringValue = ""
                txtUserName.stringValue = ""
                txtConfirmarPassword.stringValue = ""
                self.view.window?.windowController?.close()
            }else{
                lblConfirmarPassword.stringValue = "Contraseña incorrecta"
                lblConfirmarPassword.textColor = NSColor.red
                
            }
        }
    }
    
    func alerta() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Verifica los campos, puede que tengas errores"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
}

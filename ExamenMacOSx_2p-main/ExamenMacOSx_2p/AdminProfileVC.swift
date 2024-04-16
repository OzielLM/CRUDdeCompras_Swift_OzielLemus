//
//  AdminProfileVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 13/05/23.
//

import Cocoa

class AdminProfileVC: NSViewController, NSComboBoxDataSource, NSComboBoxDelegate {
    var flag: Bool = false
    var posicion: Int?
    var loginController = LoginController.compartir
    var contadorID = User.contador
    
    
    var color1=""
    var imagen1=""
    
    
    let colores=["rojo","azul","verde","amarillo","naranja","ninguno"]
    
    let imagen=["redAzul","olaAzul","marcoRosa","arcoNaranja","arcoAzul","ninguno"]
    
    @IBOutlet weak var txtId: NSTextField!
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtApellidoP: NSTextField!
    @IBOutlet weak var txtApellidoM: NSTextField!
    @IBOutlet weak var txtUsuer: NSTextField!
    @IBOutlet weak var txtTelefono: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtGenero: NSComboBox!    
    @IBOutlet weak var txtContraseña: NSSecureTextField!
    @IBOutlet weak var txtConfirmarPassword: NSSecureTextField!
    @IBOutlet weak var txtRol: NSComboBox!
    @IBOutlet weak var dateNacimiento: NSDatePicker!
    @IBOutlet weak var cmbColor: NSComboBox!
    @IBOutlet weak var cmbImg: NSComboBox!
    
    @IBOutlet weak var lblConfirmarContraseña: NSTextField!
    
    
    @IBOutlet weak var btnCreate: NSButton!
    @IBOutlet weak var btnUpdate: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtId.isEnabled = false
        txtId.stringValue = String(contadorID)
        btnUpdate.isHidden = !flag
        btnCreate.isHidden = flag
        
        if flag {
            txtId.integerValue = loginController.users[posicion!].id
            txtNombre.stringValue = loginController.users[posicion!].nombre
            txtApellidoP.stringValue =    loginController.users[posicion!].apellidoP
           
            txtApellidoM.stringValue  = loginController.users[posicion!].apellidoM
            
            txtUsuer.stringValue  = loginController.users[posicion!].username
            
            
            txtTelefono.stringValue  = loginController.users[posicion!].telefono
            
            
            txtEmail.stringValue  = loginController.users[posicion!].email
            
            
            txtGenero.stringValue  = loginController.users[posicion!].genero
            
            cmbColor.stringValue = loginController.users[posicion!].fondo
            
            cmbImg.stringValue = loginController.users[posicion!].imagen
            
            txtContraseña.stringValue  = loginController.users[posicion!].password
            
            txtRol.integerValue = loginController.users[posicion!].role
            
            dateNacimiento.dateValue = loginController.users[posicion!].fechaNacimiento
        }
        
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
    @IBAction func addEvent(_ sender: NSButton) {
        
        imagen1 = cmbImg.stringValue
        color1=cmbColor.stringValue
        
        if validacionDeCampos() {
            loginController.users.append(User(txtUsuer.stringValue, txtContraseña.stringValue, txtNombre.stringValue, txtApellidoP.stringValue, txtApellidoM.stringValue, txtEmail.stringValue, txtTelefono.stringValue, txtGenero.stringValue, Int(txtRol.intValue), calcularEdad(dateNacimiento),dateNacimiento.dateValue,color1,imagen1))
            print("Actualizado")
            self.view.window?.windowController?.close()
        }
        else {
            alerta()
        }
        
        print(dateNacimiento.dateValue)
        
        
        
    }
    
    @IBAction func updateEvent(_ sender: NSButton) {
        
        imagen1 = cmbImg.stringValue
        color1=cmbColor.stringValue
        
        if validacionDeCampos() {
            loginController.users[posicion!].id = Int(txtId.intValue)
            loginController.users[posicion!].nombre = txtNombre.stringValue
            loginController.users[posicion!].apellidoP = txtApellidoP.stringValue
            loginController.users[posicion!].apellidoM = txtApellidoM.stringValue
            loginController.users[posicion!].username = txtUsuer.stringValue
            loginController.users[posicion!].telefono = txtTelefono.stringValue
            loginController.users[posicion!].email = txtEmail.stringValue
            loginController.users[posicion!].genero = txtGenero.stringValue
            loginController.users[posicion!].fondo = cmbColor.stringValue
            loginController.users[posicion!].imagen = cmbImg.stringValue
            loginController.users[posicion!].password = txtContraseña.stringValue
            loginController.users[posicion!].role = txtRol.integerValue
            loginController.users[posicion!].fechaNacimiento = dateNacimiento.dateValue
            print("Actualizado")
            dismiss(self)
        } else {
            alerta()
        }
        
        
        
        
    }
    
    func calcularEdad(_ datePicker: NSDatePicker) -> Int {
        let birthDate = datePicker.dateValue
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        let age = ageComponents.year!
        
        return age
    }
    
    func validacionDeCampos() -> Bool{
        var estado = false
        if txtUsuer.stringValue == "" || txtContraseña.stringValue == "" || txtNombre.stringValue == "" || txtApellidoP.stringValue == "" || txtApellidoM.stringValue == "" || txtTelefono.stringValue == "" || txtEmail.stringValue == "" || txtGenero.stringValue == "" || txtRol.stringValue == "" || cmbColor.stringValue == "" || cmbImg.stringValue == "" || txtNombre.stringValue.range(of: "[0-9]", options: .regularExpression) != nil || txtApellidoP.stringValue.range(of: "[0-9]", options: .regularExpression) != nil || txtApellidoM.stringValue.range(of: "[0-9]", options: .regularExpression) != nil || !txtEmail.stringValue.contains("@") || txtContraseña.stringValue.count < 8 || txtTelefono.stringValue.count != 10 || txtTelefono.stringValue.range(of: "[a-z]", options: .regularExpression) != nil{
        }
        else{
            if txtContraseña.stringValue == txtConfirmarPassword.stringValue {
                estado = true
            }else{
                lblConfirmarContraseña.stringValue = "Contraseña incorrecta"
                lblConfirmarContraseña.textColor = NSColor.red
            }
            
        }
        return estado
    }
    
    func alerta() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Verifica los campos, puede que tengas errores"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
}

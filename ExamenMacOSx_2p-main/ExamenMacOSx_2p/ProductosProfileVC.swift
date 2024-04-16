//
//  ProductosProfileVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 16/05/23.
//

import Cocoa

class ProductosProfileVC: NSViewController {
    var flag: Bool = false
    var posicion: Int?
    var usuario: String = ""
    var productosController = ProductosController.compartir
    var loginController = LoginController.compartir
    var usuarioRecibido2:String?
    var color1:NSColor?
    var contadorID = Product.contador
    
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
            if usuarioRecibido2==loginController.users[x].username{
                img.image=NSImage(named: loginController.users[x].imagen)
                asignarColor(loginController.users[x].fondo)
                view.wantsLayer = true
                view.layer?.backgroundColor=color1?.cgColor
            }
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        txtID.isEnabled = false
        txtID.stringValue = String(contadorID)
        btnModificar.isHidden = !flag
        btnCrear.isHidden = flag
        usuario = usuarioRecibido2!
        setValue()
        
        
        if flag {
            txtID.integerValue = productosController.productos[posicion!].id
            txtNombre.stringValue = productosController.productos[posicion!].nombre
            txtDescripcion.stringValue = productosController.productos[posicion!].descripcion
            cmbUnidad.stringValue = productosController.productos[posicion!].unidad
            txtPrecio.doubleValue = productosController.productos[posicion!].precio
            txtCosto.doubleValue = productosController.productos[posicion!].costo
            cmbCategoria.stringValue = productosController.productos[posicion!].categoría
            txtCantidad.integerValue = productosController.productos[posicion!].cantidad
        }
    }
    
    @IBAction func addEvent(_ sender: NSButton) {
        //agregar validaciones
        if validacionDeCampos(){
            productosController.productos.append(Product(txtNombre.stringValue, txtDescripcion.stringValue, cmbUnidad.stringValue, Double(txtPrecio.doubleValue), Double(txtCosto.doubleValue),cmbCategoria.stringValue, Int(txtCantidad.integerValue)))
            print("Actualizado")
            self.view.window?.windowController?.close()
        }else{
            alertaCampos()
        }
    }
    
    @IBAction func updateEvent(_ sender: NSButton) {
        //agregar validaciones
        if validacionDeCampos(){
            productosController.productos[posicion!].id = txtID.integerValue
            productosController.productos[posicion!].nombre = txtNombre.stringValue
            productosController.productos[posicion!].descripcion = txtDescripcion.stringValue
            productosController.productos[posicion!].unidad = cmbUnidad.stringValue
            productosController.productos[posicion!].precio = txtPrecio.doubleValue
            productosController.productos[posicion!].costo = txtCosto.doubleValue
            productosController.productos[posicion!].categoría = cmbCategoria.stringValue
            productosController.productos[posicion!].cantidad = txtCantidad.integerValue
                print("Actualizado")
            self.view.window?.windowController?.close()
        }else{
            alertaCampos()
        }
        
    }
    
    func validacionDeCampos() -> Bool{
        var estado = false
        if txtNombre.stringValue == "" || txtDescripcion.stringValue == "" || cmbUnidad.stringValue == "" || txtPrecio.stringValue == "" || txtCosto.stringValue == "" || cmbCategoria.stringValue == "" || txtCantidad.stringValue == ""{
        }
        else{
            estado = true
        }
        return estado
    }
    
    func alertaCampos() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "Verifica los campos, puede que tengas errores"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
        
    
    
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtDescripcion: NSTextField!
    @IBOutlet weak var cmbUnidad: NSComboBox!
    @IBOutlet weak var txtPrecio: NSTextField!
    @IBOutlet weak var txtCosto: NSTextField!
    @IBOutlet weak var cmbCategoria: NSComboBox!
    @IBOutlet weak var txtCantidad: NSTextField!
    
    
    @IBOutlet weak var btnCrear: NSButton!
    @IBOutlet weak var btnModificar: NSButton!
    
    
    @IBOutlet weak var img: NSImageCell!
    
    
}

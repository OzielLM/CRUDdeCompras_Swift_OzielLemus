//
//  ComprasProfileVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 18/05/23.
//

import Cocoa

class ComprasProfileVC: NSViewController {
    var usuarioRecibido:String?
    var usuario: String = ""
    var flag: Bool = false
    var posicion: Int?
    var comprasController = ComprasController.compartir
    var loginController = LoginController.compartir
    var productosController = ProductosController.compartir
    var sumaCantidades:Int = 0
    var color1:NSColor?
    var contadorID = Compra.contador
    
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
        setValue()
        usuario = usuarioRecibido!
        lblUsuario.stringValue = usuario
        txtIDCompra.isEnabled = false
        txtIdComprador.isEnabled = false
        txtIDCompra.stringValue = String(contadorID)
        btnModificar.isHidden = !flag
        btnCrear.isHidden = flag
        txtIdComprador.integerValue = identificarIdComprador(lblUsuario)
        if flag {
            //informacion del comprador
            lblNombreComprador.stringValue = comprasController.compras[posicion!].username
            lblApellidoPaternoComprador.stringValue = comprasController.compras[posicion!].apellidoP
            lblApellidoMaternoComprador.stringValue = comprasController.compras[posicion!].apellidoM
            lblCorreo.stringValue = comprasController.compras[posicion!].email
            lblTelefono.stringValue = comprasController.compras[posicion!].telefono
            //informacion del producto
            lblIDproducto.integerValue = comprasController.compras[posicion!].idProducto
            lblNombreProducto.stringValue = comprasController.compras[posicion!].nombre
            lblDescripcionProducto.stringValue = comprasController.compras[posicion!].descripcion
            lblUnidadProducto.stringValue = comprasController.compras[posicion!].unidad
            lblPrecioProducto.doubleValue = comprasController.compras[posicion!].precio
            lblCostoProducto.doubleValue = comprasController.compras[posicion!].costo
            lblCategoria.stringValue = comprasController.compras[posicion!].categoría
            lblExitenciaProducto.integerValue = comprasController.compras[posicion!].cantidadProducto
            //formulario
            txtIDCompra.integerValue = comprasController.compras[posicion!].id
            txtIdProducto.integerValue = comprasController.compras[posicion!].idProducto
            txtCantidadCompra.integerValue = comprasController.compras[posicion!].cantidad
            txtIdComprador.integerValue = comprasController.compras[posicion!].idComprador
        }
        
        
    }
    
    
    @IBAction func alta(_ sender: Any) {
        if validacionID(){
            comprasController.compras.append(Compra(Int(txtIdProducto.integerValue),Int(txtCantidadCompra.integerValue),txtIdComprador.integerValue,lblNombreProducto.stringValue,lblDescripcionProducto.stringValue,lblUnidadProducto.stringValue,Double(lblPrecioProducto.doubleValue),Double(lblCostoProducto.doubleValue),lblCategoria.stringValue,lblExitenciaProducto.integerValue,lblNombreComprador.stringValue,lblApellidoPaternoComprador.stringValue,lblApellidoMaternoComprador.stringValue,lblCorreo.stringValue,lblTelefono.stringValue))
            print("se hizo la alta")
            self.view.window?.windowController?.close()
        }else{
            alertaValidacion()
        }
        
        
        
    }
    
    
    @IBAction func btnAplicarCambios(_ sender: Any) {
        //Informacion del producto
        if validacionID(){
            setProducto()
            setInfoComprador()
        }else{
            alertaValidacion()
        }
        
        
     
    }
    
    
    @IBAction func Actualizar(_ sender: Any) {
        //sale paro en debug checar mañana
        if validacionID(){
            comprasController.compras[posicion!].username = lblNombreComprador.stringValue
            comprasController.compras[posicion!].apellidoP = lblApellidoPaternoComprador.stringValue
            comprasController.compras[posicion!].apellidoM = lblApellidoMaternoComprador.stringValue
            comprasController.compras[posicion!].email = lblCorreo.stringValue
            comprasController.compras[posicion!].telefono = lblTelefono.stringValue
            //informacion del producto
            comprasController.compras[posicion!].idProducto = lblIDproducto.integerValue
            comprasController.compras[posicion!].nombre = lblNombreProducto.stringValue
            comprasController.compras[posicion!].descripcion = lblDescripcionProducto.stringValue
            comprasController.compras[posicion!].unidad = lblUnidadProducto.stringValue
            comprasController.compras[posicion!].precio = lblPrecioProducto.doubleValue
            comprasController.compras[posicion!].costo = lblCostoProducto.doubleValue
            comprasController.compras[posicion!].categoría = lblCategoria.stringValue
            comprasController.compras[posicion!].cantidadProducto = lblExitenciaProducto.integerValue
            //formulario
            comprasController.compras[posicion!].id = txtIDCompra.integerValue
            comprasController.compras[posicion!].idProducto = txtIdProducto.integerValue
            comprasController.compras[posicion!].cantidad = txtCantidadCompra.integerValue
            comprasController.compras[posicion!].idComprador = txtIdComprador.integerValue
            print("actualizacion de compra")
            self.view.window?.windowController?.close()
        }else{
            alertaValidacion()
        }
        
        
    }

    func setProducto(){
        for x in 0 ... productosController.productos.count-1{
            if(txtIdProducto.integerValue==productosController.productos[x].id){
                lblIDproducto.stringValue = " \(productosController.productos[x].id)"
                lblNombreProducto.stringValue = productosController.productos[x].nombre
                lblDescripcionProducto.stringValue = productosController.productos[x].descripcion
                lblUnidadProducto.stringValue = productosController.productos[x].unidad
                lblPrecioProducto.stringValue = "\(productosController.productos[x].precio)"
                lblCostoProducto.stringValue = "\(productosController.productos[x].costo)"
                lblCategoria.stringValue = productosController.productos[x].categoría
                sumaCantidades=txtCantidadCompra.integerValue + productosController.productos[x].cantidad
                productosController.productos[x].cantidad = sumaCantidades
                lblExitenciaProducto.stringValue = "\(sumaCantidades)"
                
            }
        }
    }
    
    func setInfoComprador(){
        for x in 0 ...
        loginController.users.count-1{
            if(txtIdComprador.integerValue==loginController.users[x].id){
                lblNombreComprador.stringValue = loginController.users[x].nombre
                lblApellidoPaternoComprador.stringValue = loginController.users[x].apellidoP
                lblApellidoMaternoComprador.stringValue = loginController.users[x].apellidoM
                lblCorreo.stringValue = loginController.users[x].email
                lblTelefono.stringValue = "\(loginController.users[x].telefono)"
            }
        }
    }
    
    func identificarIdComprador(_ usuario: NSTextField) -> Int {
        var idComprador = 0
        for x in 0...loginController.users.count-1{
            if usuario.stringValue == loginController.users[x].username {
                idComprador = x
            }
        }
        return idComprador
    }

    //Información del comprador
    @IBOutlet weak var lblNombreComprador: NSTextField!
    @IBOutlet weak var lblApellidoPaternoComprador: NSTextField!
    @IBOutlet weak var lblApellidoMaternoComprador: NSTextField!
    @IBOutlet weak var lblCorreo: NSTextField!
    
    @IBOutlet weak var lblTelefono: NSTextField!
    @IBOutlet weak var lblUsuario: NSTextField!
    
    //Información del producto
    @IBOutlet weak var lblIDproducto: NSTextField!
    @IBOutlet weak var lblNombreProducto: NSTextField!
    @IBOutlet weak var lblDescripcionProducto: NSTextField!
    @IBOutlet weak var lblUnidadProducto: NSTextField!
    @IBOutlet weak var lblPrecioProducto: NSTextField!
    @IBOutlet weak var lblCostoProducto: NSTextField!
    @IBOutlet weak var lblCategoria: NSTextField!
    @IBOutlet weak var lblExitenciaProducto: NSTextField!
    
    
    //formulario
    @IBOutlet weak var txtIDCompra: NSTextField!
    @IBOutlet weak var txtIdProducto: NSTextField!
    @IBOutlet weak var txtCantidadCompra: NSTextField!
    @IBOutlet weak var txtIdComprador: NSTextField!
    @IBOutlet weak var btnSubmit: NSButton!
    @IBOutlet weak var btnCrear: NSButton!
    @IBOutlet weak var btnModificar: NSButton!
    
    @IBOutlet weak var img: NSImageCell!
    
    
    func validacionID() -> Bool {
        var estado = false
        if !productosController.productos.isEmpty{
            for x in 0 ... productosController.productos.count-1{
                if(txtIdProducto.integerValue==productosController.productos[x].id){
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

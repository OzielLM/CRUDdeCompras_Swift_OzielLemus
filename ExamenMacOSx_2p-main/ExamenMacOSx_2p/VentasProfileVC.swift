//
//  VentasProfileVC.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 21/05/23.
//

import Cocoa

class VentasProfileVC: NSViewController {
    var usuarioRecibido:String?
    var usuario: String = ""
    var flag: Bool = false
    var posicion: Int?
    var ventasController = VentasController.compartir
    var loginController = LoginController.compartir
    var productosController = ProductosController.compartir
    var restaExistencia:Int = 0
    var precioUnitario:Double = 0
    var subtotal:Double = 0
    var IVA:Double = 0
    var total:Double = 0
    var color1:NSColor?
    var contadorID = Venta.contador
    
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
        btnCrear.isEnabled = false
        btnModificar.isEnabled = false
        lblUsuario.stringValue = usuario
        txtIDVenta.isEnabled = false
        txtIDVendedor.isEnabled = false
        txtIDVenta.stringValue = String(contadorID)
        btnModificar.isHidden = !flag
        btnCrear.isHidden = flag
        txtIDVendedor.integerValue = identificarIdVendedor(lblUsuario)
        
        if flag {
            //informacion del vendedor
            lblNombreVendedor.stringValue = ventasController.ventas[posicion!].nombreVendedor
            lblApellidoPaternoVendedor.stringValue = ventasController.ventas[posicion!].apellidoPVendedor
            lblApellidoMaternoVendedor.stringValue = ventasController.ventas[posicion!].apellidoMVendedor
            lblCorreoVendedor.stringValue = ventasController.ventas[posicion!].emailVendedor
            lblTelefonoVendedor.stringValue = ventasController.ventas[posicion!].telefonoVendedor
            
            //informacion del cliente
            lblIDCliente.integerValue = ventasController.ventas[posicion!].idCliente
            lblNombreCliente.stringValue = ventasController.ventas[posicion!].nombreCliente
            lblApellidoPaternoCliente.stringValue = ventasController.ventas[posicion!].apellidoPCliente
            lblApellidoMaternoCliente.stringValue = ventasController.ventas[posicion!].apellidoMCliente
            lblCorreoCliente.stringValue = ventasController.ventas[posicion!].correoCliente
            lblTelefonoCliente.stringValue = ventasController.ventas[posicion!].telefonoCliente
            
            //informacion de la venta
            lblCantidad.integerValue = ventasController.ventas[posicion!].cantidadVenta
            lblUnidad.stringValue = ventasController.ventas[posicion!].unidadProducto
            lblProducto.stringValue = ventasController.ventas[posicion!].nombreProducto
            lblDescripcion.stringValue = ventasController.ventas[posicion!].descripcionProducto
            lblPrecio.doubleValue = ventasController.ventas[posicion!].precioProducto
            lblSubtotal.doubleValue = ventasController.ventas[posicion!].subtotal
            lblIVA.doubleValue = ventasController.ventas[posicion!].IVA
            lblTotal.doubleValue = ventasController.ventas[posicion!].total
            //formulario
            txtIDVenta.integerValue = ventasController.ventas[posicion!].idVenta
            txtIDProducto.integerValue = ventasController.ventas[posicion!].idProducto
            txtIDCliente.integerValue = ventasController.ventas[posicion!].idCliente
            txtCantidadVenta.integerValue = ventasController.ventas[posicion!].cantidadVenta
        }
        // Do view setup here.
    }
    
    
    func restarExistencia() -> Bool{
        
        var alta = false
        for x in 0 ... productosController.productos.count-1{
            if txtIDProducto.integerValue == productosController.productos[x].id{
                restaExistencia=productosController.productos[x].cantidad - txtCantidadVenta.integerValue
                productosController.productos[x].cantidad = restaExistencia
                
                
                
                
            alertaInventario()
                alta = true
                break
            }
            else{
                alta = false
            }
        }
        return alta
    }
    @IBAction func alta(_ sender: Any) {
        var productoEncontrado = false
        var indiceProductoEncontrado = 0

        for x in 0 ... productosController.productos.count-1 {
            if txtIDProducto.integerValue == productosController.productos[x].id {
                productoEncontrado = true
                indiceProductoEncontrado = x
                break
            }
        }
        if validarQueSeaCliente(){
            if !productosController.productos.isEmpty{
                
                if restarExistencia() || restaExistencia <= 0 {
                    ventasController.ventas.append(Venta(Int(txtIDProducto.integerValue),lblProducto.stringValue,lblDescripcion.stringValue,lblUnidad.stringValue,Double(lblPrecio.doubleValue),productosController.productos[Int(indiceProductoEncontrado)].categoría,Int(txtCantidadVenta.integerValue),lblNombreVendedor.stringValue,lblApellidoPaternoVendedor.stringValue,lblApellidoMaternoVendedor.stringValue,lblCorreoVendedor.stringValue,lblTelefonoVendedor.stringValue,Int(lblIDCliente.integerValue),lblNombreCliente.stringValue,lblApellidoPaternoCliente.stringValue,lblApellidoMaternoCliente.stringValue,lblCorreoCliente.stringValue,lblTelefonoCliente.stringValue,Double(lblSubtotal.doubleValue),Double(lblIVA.doubleValue),Double(lblTotal.doubleValue)))
                    print("se hizo la alta")
                    self.view.window?.windowController?.close()
                }else{
                    alertaInventarioInsuficiente()
                }
            }else{
                noExisteElProducto()
            }
        }else{
            alertaValidacion()
        }
        
        
    }
    
    @IBAction func Actualizar(_ sender: Any) {
        if validarQueSeaCliente(){
            if !productosController.productos.isEmpty{
                
                if restarExistencia() {
                    ventasController.ventas[posicion!].nombreVendedor = lblNombreVendedor.stringValue
                    ventasController.ventas[posicion!].apellidoPVendedor = lblApellidoPaternoVendedor.stringValue
                    ventasController.ventas[posicion!].apellidoMVendedor = lblApellidoMaternoVendedor.stringValue
                    ventasController.ventas[posicion!].emailVendedor = lblCorreoVendedor.stringValue
                    ventasController.ventas[posicion!].telefonoVendedor = lblTelefonoVendedor.stringValue
                    
                    ventasController.ventas[posicion!].idCliente = lblIDCliente.integerValue
                    ventasController.ventas[posicion!].nombreCliente = lblNombreCliente.stringValue
                    ventasController.ventas[posicion!].apellidoPCliente = lblApellidoPaternoCliente.stringValue
                    ventasController.ventas[posicion!].apellidoMCliente = lblApellidoMaternoCliente.stringValue
                    ventasController.ventas[posicion!].correoCliente = lblCorreoCliente.stringValue
                    ventasController.ventas[posicion!].telefonoCliente = lblTelefonoCliente.stringValue
                    
                    ventasController.ventas[posicion!].cantidadVenta = txtCantidadVenta.integerValue
                    ventasController.ventas[posicion!].unidadProducto = lblUnidad.stringValue
                    ventasController.ventas[posicion!].nombreProducto = lblProducto.stringValue
                    ventasController.ventas[posicion!].descripcionProducto = lblDescripcion.stringValue
                    ventasController.ventas[posicion!].precioProducto = lblPrecio.doubleValue
                    ventasController.ventas[posicion!].subtotal = lblSubtotal.doubleValue
                    ventasController.ventas[posicion!].IVA = lblIVA.doubleValue
                    ventasController.ventas[posicion!].total = lblTotal.doubleValue
                    
                    ventasController.ventas[posicion!].idVenta = txtIDVenta.integerValue
                    ventasController.ventas[posicion!].idProducto = txtIDProducto.integerValue
                    ventasController.ventas[posicion!].idCliente = txtIDCliente.integerValue
                    ventasController.ventas[posicion!].cantidadVenta = txtCantidadVenta.integerValue
                    print("actualizacion de compra")
                    self.view.window?.windowController?.close()
                }else{
                    alertaInventarioInsuficiente()
                }
            }else{
                noExisteElProducto()
            }
        }else{
            alertaValidacion()
        }
        
        
       
    }
    
    @IBAction func btnAplicarCambios(_ sender: Any) {
        //Informacion del producto
        if validarQueSeaCliente(){
            setProducto()
            //btnCrear.isEnabled = true
            //btnModificar.isEnabled = true
        }else{
            alertaValidacion()
        }
        
        
    }
    
    
    
    @IBOutlet weak var lblUsuario: NSTextField!
    
    //TXT'S
    @IBOutlet weak var txtIDVenta: NSTextField!
    @IBOutlet weak var txtIDProducto: NSTextField!
    @IBOutlet weak var txtIDCliente: NSTextField!
    @IBOutlet weak var txtCantidadVenta: NSTextField!
    @IBOutlet weak var txtIDVendedor: NSTextField!
    
    
    //Información vendedor
    @IBOutlet weak var lblNombreVendedor: NSTextField!
    @IBOutlet weak var lblApellidoPaternoVendedor: NSTextField!
    @IBOutlet weak var lblApellidoMaternoVendedor: NSTextField!
    @IBOutlet weak var lblCorreoVendedor: NSTextField!
    @IBOutlet weak var lblTelefonoVendedor: NSTextField!
    
    //Información cliente
    @IBOutlet weak var lblIDCliente: NSTextField!
    @IBOutlet weak var lblNombreCliente: NSTextField!
    @IBOutlet weak var lblApellidoPaternoCliente: NSTextField!
    @IBOutlet weak var lblApellidoMaternoCliente: NSTextField!
    @IBOutlet weak var lblCorreoCliente: NSTextField!
    @IBOutlet weak var lblTelefonoCliente: NSTextField!
    
    //Información venta
    @IBOutlet weak var lblCantidad: NSTextField!
    @IBOutlet weak var lblUnidad: NSTextField!
    @IBOutlet weak var lblProducto: NSTextField!
    @IBOutlet weak var lblDescripcion: NSTextField!
    @IBOutlet weak var lblPrecio: NSTextField!
    @IBOutlet weak var lblSubtotal: NSTextField!
    @IBOutlet weak var lblIVA: NSTextField!
    @IBOutlet weak var lblTotal: NSTextField!
    
    //Botones
    @IBOutlet weak var btnCrear: NSButton!
    @IBOutlet weak var btnModificar: NSButton!
    
    @IBOutlet weak var img: NSImageCell!
    
    
    func setProducto(){
        
        if !productosController.productos.isEmpty {
            
                
            var productoEncontrado = false
            var indiceProductoEncontrado = 0

            for x in 0 ... productosController.productos.count-1 {
                if txtIDProducto.integerValue == productosController.productos[x].id {
                    productoEncontrado = true
                    indiceProductoEncontrado = x
                    break
                }
            }

            if productoEncontrado {
                if txtCantidadVenta.integerValue <= productosController.productos[indiceProductoEncontrado].cantidad {
                    var cantidadVenta = txtCantidadVenta.stringValue
                    lblCantidad.stringValue = cantidadVenta
                    lblUnidad.stringValue = " \(productosController.productos[indiceProductoEncontrado].unidad)"
                    lblProducto.stringValue = productosController.productos[indiceProductoEncontrado].nombre
                    lblDescripcion.stringValue = productosController.productos[indiceProductoEncontrado].descripcion
                    lblPrecio.stringValue = "\(productosController.productos[indiceProductoEncontrado].precio)"
                    subtotal = txtCantidadVenta.doubleValue * lblPrecio.doubleValue
                    IVA = subtotal * 0.16
                    total = subtotal + IVA
                    lblSubtotal.stringValue = String(subtotal)
                    lblIVA.stringValue = String(IVA)
                    lblTotal.stringValue = String(total)
                    btnCrear.isEnabled = true
                    btnModificar.isEnabled = true
                    alertaInventario()
                    setInfoCliente()
                    setInfoVendedor()
                } else {
                    btnCrear.isEnabled = false
                    btnModificar.isEnabled = false
                    alertaInventarioInsuficiente()
                }
            } else {
                btnCrear.isEnabled = false
                btnModificar.isEnabled = false
                noExisteElProducto()
            }

        
        }else{
            btnCrear.isEnabled = false
            btnModificar.isEnabled = false
            noExisteElProducto()
        }
    }
    
    func setInfoVendedor(){
        for x in 0 ...
        loginController.users.count-1{
            if(txtIDVendedor.integerValue == loginController.users[x].id){
                lblNombreVendedor.stringValue = loginController.users[x].nombre
                lblApellidoPaternoVendedor.stringValue = loginController.users[x].apellidoP
                lblApellidoMaternoVendedor.stringValue = loginController.users[x].apellidoM
                lblCorreoVendedor.stringValue = loginController.users[x].email
                lblTelefonoVendedor.stringValue = "\(loginController.users[x].telefono)"
                break
            }
        }
    }
    
    func noExisteElProducto() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "No existe un producto con este ID, consulta la lista de los productos"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func alertaInventarioInsuficiente() -> Bool {
        let alert: NSAlert = NSAlert()
        var productoEncontrado = false
        var indiceProductoEncontrado = 0
        
        for x in 0 ... productosController.productos.count-1 {
            if txtIDProducto.integerValue == productosController.productos[x].id {
                productoEncontrado = true
                indiceProductoEncontrado = x
                alert.messageText = "La existencia de este producto es \(productosController.productos[indiceProductoEncontrado].cantidad), avisa al comprador que pida más para completar la venta u ofrecele al cliente la existencia"
                alert.alertStyle = .informational
                alert.addButton(withTitle: "Ok")
                break
            }
        }
        
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func alertaInventario() -> Bool {
        let alert: NSAlert = NSAlert()
        var productoEncontrado = false
        var indiceProductoEncontrado = 0
        
        for x in 0 ... productosController.productos.count-1 {
            if txtIDProducto.integerValue == productosController.productos[x].id {
                productoEncontrado = true
                indiceProductoEncontrado = x
                alert.messageText = "Queda \(productosController.productos[indiceProductoEncontrado].cantidad) de \(lblProducto.stringValue)"
                alert.alertStyle = .informational
                alert.addButton(withTitle: "Ok")
                
                break
            }
        }
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    func setInfoCliente(){
        for x in 0 ...
        loginController.users.count-1{
            if(txtIDCliente.integerValue == loginController.users[x].id){
                lblIDCliente.integerValue = loginController.users[x].id
                lblNombreCliente.stringValue = loginController.users[x].nombre
                lblApellidoPaternoCliente.stringValue = loginController.users[x].apellidoP
                lblApellidoMaternoCliente.stringValue = loginController.users[x].apellidoM
                lblCorreoCliente.stringValue = loginController.users[x].email
                lblTelefonoCliente.stringValue = "\(loginController.users[x].telefono)"
                break
            }
        }
    }
    
    func identificarIdVendedor(_ usuario: NSTextField) -> Int {
        var idVendedor = 0
        for x in 0...loginController.users.count-1{
            if usuario.stringValue == loginController.users[x].username {
                idVendedor = x
                break
            }
        }
        return idVendedor
    }
    
    func validarQueSeaCliente() -> Bool {
        var estado = false
        if !loginController.users.isEmpty{
            var idCliente = 0
            for x in 0...loginController.users.count-1{
                if(txtIDCliente.integerValue == loginController.users[x].id){
                    idCliente = x
                    break
                }
            }
            
            for _ in 0 ... loginController.users.count-1{
                if(loginController.users[idCliente].role == 1){
                    estado = true
                    break
                }
            }
        }else{
            estado = false
        }
        return estado
    }
    
    func alertaValidacion() -> Bool {
        let alert: NSAlert = NSAlert()
        alert.messageText = "No existe un cliente con este ID, verifica en la lista de usuarios los ID de los clientes"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
}

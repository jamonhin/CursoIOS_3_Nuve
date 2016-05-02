//
//  ViewController.swift
//  Tarea_1_Peticion_HTTP
//
//  Created by James Montoya on 24/04/16.
//  Copyright © 2016 James Montoya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    //Variable donde se obtiene libro a buscar
    @IBOutlet weak var txtLibro: UITextField!
    @IBOutlet weak var txtResultado: UITextView!
    
    
    /**
     * Llamado cuando la tecla "retorno" presionado. NO volver a pasar por alto.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Se llama cuando el usuario haga clic en la vista (fuera del UITextField).
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func limpiarBusqueda(sender: AnyObject) {
        
        self.txtLibro.text=""
        self.txtResultado.text=""
        
    }
    
    @IBAction func buscarLibro(sender: AnyObject) {
        consultarLibro()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            txtLibro.delegate = self
            //txtResultado.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func consultarLibro()  {
        
        if  (self.txtLibro.text != "") {
                
                
                var libro : String?
                
                 libro = String(self.txtLibro.text!)
                
                let urls: String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + libro!
                //print(urls)
                //self.txtResultado.text = "Esperando Respuesta..."
                
                let url = NSURL(string: urls)
                let datos: NSData? = NSData(contentsOfURL: url!)
                let respuesta = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                
                //manejo de errores
            do {
                
                if  String(respuesta) !=   "Optional({})" {
                    
                    let json =  try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                    let dic1 = json as! NSDictionary
                    let dic2 = dic1["ISBN:" + libro!] as! NSDictionary
                    
                    var autores: String = ""
                    
                    var names = [String]()
                    
                    // Debemos validar si existe la clave authors o cualquier otro nodo del json ya que si no existe nos saldra un error
                    
                    if let _ = dic2["authors"] {
                        //Si existe como nos devuelve un arreglo ya que inicia con [] lo debmos leer asi con un ciclo
                        let dic3 = dic2["authors"] as? [[String: AnyObject]]
                        for dic3 in dic3! {
                            if let name = dic3["name"] as? String {
                                names.append(name)
                            }
                        }
                        for element in names {
                            autores = element + ", " + autores
                        }
                      
                    }
                    else {
                        autores = "No se encontraron autores"
                    }
                    
 
                    self.txtResultado.text =  "Titulo del libro: " + String(dic2["title"]!) + ", Autores del Libro: " + autores + " y portada: Sin informacion "
                    
                } else {
                    self.txtResultado.text = "No se encontraron resultados para esta busqueda.."
                }
                
            }
            catch _ {
                self.txtResultado.text = "Error en la conexion a Internet, Verifique su conexion y vuelva a intentar la tarea"
            }
               
            
        } else {
        
            let alertController = UIAlertController(title: "Mensaje Alerta", message:
                "Debe ingresar un numero ISBN antes de dar clic en la lupa", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        
        }
 
        
    
    }


}


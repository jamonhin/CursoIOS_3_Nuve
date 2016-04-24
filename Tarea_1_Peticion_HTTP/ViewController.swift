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
        
        if  self.txtLibro.text != "" {
        var libro : String?
        
        libro = String(self.txtLibro.text!)
        
        let urls: String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + libro!
        print(urls)
        //self.txtResultado.text = "Esperando Respuesta..."
        
        let url = NSURL(string: urls)
        let datos: NSData? = NSData(contentsOfURL: url!)
        let respuesta = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        
        print(respuesta)
        
        self.txtResultado.text = String(respuesta)
            
        } else {
        
            let alertController = UIAlertController(title: "Mensaje Alerta", message:
                "Debe ingresar un numero ISBN Valido", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        
        }
 
        
    
    }


}


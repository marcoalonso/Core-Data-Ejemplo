//
//  ViewController.swift
//  Core Data Ejemplo
//
//  Created by marco rodriguez on 10/05/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var contactos: [NSManagedObject]?
    
    func conexionBD() -> NSManagedObjectContext {
        let delegado = UIApplication.shared.delegate as! AppDelegate
        return delegado.persistentContainer.viewContext
    }
    
    
    @IBOutlet weak var telefonoGuardar: UITextField!
    @IBOutlet weak var nombreGuardar: UITextField!
    
    @IBOutlet weak var nombreMostrar: UITextField!
    
    @IBOutlet weak var telefonoMostrar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func guardarButton(_ sender: UIButton) {
        guard let nombreTF = nombreGuardar.text else { return }
        guard let telefonoTF = telefonoGuardar.text else { return }
        
        let context = conexionBD()
        
        let queryContacto = NSEntityDescription.insertNewObject(forEntityName: "Contacto", into: context) as! Contacto
        queryContacto.nombre = nombreTF
        queryContacto.telefono = Int64(telefonoTF)!
        
        do {
            try context.save()
            print("Se guardó en la bd")
        } catch {
            print("Error al guardar el contexto: \(error.localizedDescription)")
        }
        
    }
    
    
    func leerDB() {
        let context = conexionBD()
        
        let solicitudLectura : NSFetchRequest<Contacto> = Contacto.fetchRequest()
        do {
             contactos = try context.fetch(solicitudLectura) as [NSManagedObject]
        } catch {
            print("Error al cargar info de la BD :\(error.localizedDescription)")
        }
    }
    @IBAction func LeerButton(_ sender: UIButton) {
        leerDB()
        
        if let numContactos = contactos?.count {
            print("contactos: \(numContactos)")

            if contactos!.count > 0 {
                
            
            
            nombreMostrar.text = "\(contactos?[0].value(forKey: "nombre") ?? "No hay ningun contacto")"
            telefonoMostrar.text = "\(contactos?[0].value(forKey: "telefono") ?? 0000000)"
            } else {
                nombreMostrar.text = "No hay ningun registro"
                telefonoMostrar.text = "No hay ningun registro"
            }
            
        }
        
    }
    
    
}


//
//  Service.swift
//  Butler
//
//  Created by Luis Armando Chávez Soto on 22/02/16.
//  Copyright © 2016 Yamblet. All rights reserved.
//

import Foundation

class Service: BaseItem {

    var nombre: String?
    var descripcion: String?
    var lugar: String?
    var status_recompensa: Float?
    var ubicacion:[String:AnyObject]?
    var lista_invitados:[AnyObject]?

    
    override func update(dict: [String : AnyObject]?) {
        super.update(dict)
        nombre = dict?["nombre"] as? String
        descripcion = dict?["descripcion"] as? String
        lugar = dict?["lugar"] as? String
        status_recompensa = dict?["status_recompensa"] as? Float
        ubicacion = dict?["ubicacion"] as? [String:AnyObject]
        lista_invitados = dict?["lista_invitados"] as? [AnyObject]
    }
    

}

//
//  ConductorUbicacion.swift
//  Rutappy
//
//  Copyright © 2017 Novus. All rights reserved.
//

import Foundation
import SwiftyJSON

class ConductorUbicacion{
    var vehiculoId: Int!
    var placa: String!
    var latitud: Float!
    var longitud: Float!
    var angulo: Float!
    var velocidad: Float!
    var actividad: Float!
    var descripcion: String!
    var transcurrido: String!
    
    func ubicacionFromJson(_ json: JSON) -> ConductorUbicacion{
    
        let u = ConductorUbicacion()
    
        u.vehiculoId = json["vehiculoId"].intValue
        u.placa = json["placa"].stringValue
        u.latitud = json["latitud"].floatValue
        u.longitud = json["longitud"].floatValue
        u.angulo = json["angulo"].floatValue
        u.velocidad = json["velocidad"].floatValue
        u.actividad = json["actividad"].floatValue
        u.descripcion = json["descripcion"].stringValue
        u.transcurrido = json["transcurrido"].stringValue
        
        return u
    
    }
}

//
//  Ruta.swift
//  Rutappy
//
//  Copyright © 2017 Novus. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

class Ruta{
    
    var conductor: Conductor!
    var vehiculo: Vehiculo!
    var rutaId: Int!
    var servicioId: Int!
    var codigo: String!
    var descripcion: String!
    var inicio: PuntoGeografico!
    var fin: PuntoGeografico!
    var trazado = [CLLocationCoordinate2D]()
    var paraderos = [CLLocationCoordinate2D]()
    
    
    func rutaFromJson(_ json: JSON)-> Ruta{
        let r = Ruta()
        
        r.conductor = Conductor().conductorFromJson(json["conductor"])
        r.vehiculo = Vehiculo().vehiculoFromJson(json["vehiculo"])
        r.rutaId = json["rutaId"].intValue
        r.servicioId = json["servicioId"].intValue
        r.codigo = json["codigo"].stringValue
        r.descripcion = json["descripcion"].stringValue
        r.inicio = PuntoGeografico().puntoFromJson(json["inicio"])
        r.fin = PuntoGeografico().puntoFromJson(json["fin"])
        
        for  (_,subJson):(String, JSON) in json["trazado"]{
            
            let coordinate = CLLocationCoordinate2D(latitude: subJson["latitud"].doubleValue, longitude: subJson["longitud"].doubleValue)
            trazado.append(coordinate)
        }
        
        for  (_,subJson):(String, JSON) in json["paraderos"]{
            
            let coordinate = CLLocationCoordinate2D(latitude: subJson["latitud"].doubleValue, longitude: subJson["longitud"].doubleValue)
            paraderos.append(coordinate)
        }
        
        return r
    }
    
    
}

class Conductor{
    var personaId: Int!
    var identificacion: String!
    var name: String!
    var lastname: String!
    var fullName: String!
    var numberPhone1: String!
    var imagenPerfil: String!
    
    func conductorFromJson(_ json: JSON) -> Conductor{
        let c = Conductor()
        
        c.personaId = json["personaId"].intValue
        c.identificacion = json["identificacion"].stringValue
        c.name = json["name"].stringValue
        c.lastname = json["lastname"].stringValue
        c.fullName = json["fullName"].stringValue
        c.numberPhone1 = json["numberPhone1"].stringValue
        c.imagenPerfil = json["imagenPerfil"].stringValue
        
        return c
    }
  
}

class Vehiculo{
    
    var vehiculoId: Int!
    var movil: String!
    var placa: String!
    
    func vehiculoFromJson(_ json: JSON) -> Vehiculo{
        let v = Vehiculo()
        
        v.vehiculoId = json["vehiculoId"].intValue
        v.movil = json["movil"].stringValue
        v.placa = json["placa"].stringValue
        
        return v
    }
}

class PuntoGeografico{
    
    var id: Int!
    var descripcion: String!
    var latitud: Float!
    var longitud: Float!
    var hora: Double!
    
    func puntoFromJson(_ json: JSON) -> PuntoGeografico{
        let p = PuntoGeografico()
        
        p.id = json["id"].intValue
        p.descripcion = json["descripcion"].stringValue
        p.latitud = json["latitud"].floatValue
        p.longitud = json["longitud"].floatValue
        p.hora = json["hora"].doubleValue
        
        return p
    }
}

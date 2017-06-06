//
//  User.swift
//  Rutappy
//
//  Created by Miguel Roncallo on 4/4/17.
//  Copyright © 2017 Novus. All rights reserved.
//

import Foundation
import SwiftyJSON

class User{
    var name: String!
    var lastName: String!
    var fullName: String!
    var empresa: Empresa!
    var estado: String!
    var numberPhone: String!
    var carnet: String!
    var user: String!
    var email: String!
    var address: String!
    var homeGps: String!
    var ultimoIngreso: Float!
    var imagen: String!
    var id: Int!

    func userFromJson(_ json: JSON) -> User{
        let u = User()
        
        u.name = json["name"].stringValue
        u.lastName = json["lastname"].stringValue
        u.fullName = json["fullName"].stringValue
        u.empresa = Empresa().empresaFromJson(json["empresa"])
        u.estado = json["estado"].stringValue
        u.numberPhone = json["numberPhone1"].stringValue
        u.carnet = json["carnet"].stringValue
        u.user = json["user"].stringValue
        u.email = json["email"].stringValue
        u.address = json["address"].stringValue
        u.homeGps = json["homeGps"].stringValue
        u.ultimoIngreso = json["ultimoIngreso"].floatValue
        u.imagen = json["imagen"].stringValue
        u.id = json["id"].intValue
        
        return u
    }
}

class Empresa{
    var id: Int!
    var descripcion: String!
    
    func empresaFromJson(_ json: JSON) -> Empresa{
        
        let e = Empresa()
        
        e.id = json["id"].intValue
        e.descripcion = json["description"].stringValue
        
        return e
    }
}
//name": "ERIC GARCIA TM1",
//"lastname": "NULL",
//"fullName": "ERIC GARCIA TM1 NULL",
//"estado": "A",
//"numberPhone1": "3126074380",
//"carnet": "",
//"user": "1045676558",
//"email": "eralex2007@gmail.com",
//"address": "CRA",
//"homeGps": "10.393311788790578,-75.48316808465574",
//"ultimoIngreso": 1491333815461, <- since 1970
//"imagen": "http://104.236.83.255/usuarios/default8.jpg"

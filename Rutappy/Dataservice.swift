//
//  Dataservice.swift
//  Rutappy
//
//  Created by Miguel Roncallo on 4/4/17.
//  Copyright © 2017 Novus. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService{
    
    static let sharedInstance = DataService()
    
    let baseUrl = "http://rutappy.co:8080/escolappws/webresources"
    
    var currentUser = User()
    var metros = 0
    
    func login(_ username: String, _ password: String, _ cb: @escaping(NSError?, User?)->() ){
        
        let url = URL(string: "\(baseUrl)/user/login")
        
        let params = ["user": username,
                      "password": password,
                      "perfil": ["id":"8"]] as [String : Any]
        
        Alamofire.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                
                print(response)
                
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:json["mensaje"].stringValue]
                            ), nil)
                        }else{
                            
                            self.currentUser = User().userFromJson(json)
                            
                            cb(nil, self.currentUser)
                        }
                        
                        
                    }
                    
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
        }
    }
    
    func signUp(_ name: String, _ email: String, _ password: String, _ id: String, cb: @escaping(NSError?)->()){
        
        let url = URL(string: "\(baseUrl)/user/registrarUsuarioCorporativo")
        
        let params = ["empresa":["id": "2"],
                      "identificacion" : id,
                      "tipoIdentificacion": ["id":"2"],
                      "name": name,
                      "email": email,
                      "password": password,
                      "perfil": ["id": "8"]] as [String : Any]
        
        Alamofire.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                print(response)
                
                
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:json["mensaje"].stringValue]
                            ))
                        }else{
                            
                            self.currentUser = User().userFromJson(json)
                            
                            cb(nil)
                        }
                        
                        
                    }
                    
                case .failure(let error):
                    cb(error as NSError!)
                }
        }
    }
    
    func loadData(_ cb: @escaping (NSError?)->()){
        
        let url = URL(string: "\(baseUrl)/properties/findbyall")
        
        let params = ["userId": currentUser.id] as [String: Any]
        
        
        
        Alamofire.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default)
        .validate()
        .responseJSON { (response) in
            print(response)
            switch response.result{
            case .success:
                
                if let value = response.result.value{
                    
                    let json = JSON(value)
                    
                    if !json["success"].boolValue{
                        cb(NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:json["mensaje"].stringValue]
                        ))
                    }else{
                        
                        self.metros = json["appUsuarioDistanciaAvisoEnMetros"].intValue
                        cb(nil)
                    }
                    
                    
                }
                
            case .failure(let error):
                cb(error as NSError!)
            }
        }
        
    }
    
    func getRuta(_ cb: @escaping (Ruta?, Error?)->()){
        let url = URL(string: "\(baseUrl)/rutas/getPasajero")
        
        let params = ["agente": currentUser.id] as [String: Any]
        
        Alamofire.request(url!, method: .get, parameters: params, encoding: JSONEncoding.default).validate()
        .responseJSON { (response) in
            print(response)
            
            switch response.result{
            case .success:
                
                if let value = response.result.value{
                    
                    let json = JSON(value)
                    
                    if !json["success"].boolValue{
                        cb(nil, NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Error al cargar la ruta"]
                        ))
                    }else{
                        let r = Ruta().rutaFromJson(json)
                        cb(r, nil)
                    }
                    
                    
                }
                
            case .failure(let error):
                cb(nil, error as NSError!)
            }
        }
    }
    
    func getDriver(_ ruta: Ruta, _ cb: @escaping (ConductorUbicacion?, Error?)->()){
        let url = URL(string: "\(baseUrl)/location/findByPosition")
        
        let params = ["conductorId": ruta.conductor.personaId] as [String: Any]
        
        Alamofire.request(url!, method: .get, parameters: params, encoding: JSONEncoding.default).validate()
        .responseJSON { (response) in
            print(response)

            switch response.result{
            case .success:
                
                if let value = response.result.value{
                    
                    let json = JSON(value)
                    
                    if !json["success"].boolValue{
                        cb(nil, NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Error al cargar la ubicación del conductor"]
                        ))
                    }else{
                        let u = ConductorUbicacion().ubicacionFromJson(json)
                        cb(u, nil)
                    }
                    
                    
                }
                
            case .failure(let error):
                cb(nil, error as NSError!)
            }
        }
    }
    
}

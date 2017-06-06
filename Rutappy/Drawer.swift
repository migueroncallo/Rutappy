//
//  Drawer.swift
//  Rutappy
//
//  Copyright © 2017 Novus. All rights reserved.
//

import Foundation
import GoogleMaps

class RouteHelper{
    func drawRoute(_ ruta: Ruta, _ map: GMSMapView){
        let path = GMSMutablePath()
        
        
        for punto in ruta.trazado{
            path.add(punto)
        }
        
        let route = GMSPolyline(path: path)
        route.map = map
    }
}

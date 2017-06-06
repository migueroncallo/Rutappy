//
//  MapController.swift
//  Rutappy
//
//  Created by Miguel Roncallo on 4/10/17.
//  Copyright © 2017 Novus. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftMQTT
import SlideMenuControllerSwift


class MapController: UIViewController{

    var locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: UIView!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        //10.963889, -74.796389
        
        MQTTService.sharedInstance.mqttSession.subscribe(to: "/Barranquilla/temp", delivering: .atLeastOnce) { (subscribed, error) in
            
            if subscribed{
                print("Subscribed")
            }
        }
        
        MQTTService.sharedInstance.mqttSession.delegate = self
        var camera = GMSCameraPosition()
        if let _ = currentLocation{
             camera = GMSCameraPosition.camera(withLatitude: currentLocation!.latitude, longitude: currentLocation!.longitude, zoom: 100.0)
        }else{
             camera = GMSCameraPosition.camera(withLatitude: 10.963889, longitude: -74.796389, zoom: 100.0)
        }
        let map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        map.isMyLocationEnabled = false
        view = map
    }
    
    @IBAction func mostrarSugerencias(_ sender: UIButton) {
        
    }
    
    @IBAction func openMenu(_ sender: UIButton) {
        slideMenuController()?.openLeft()
    }
    
    @IBAction func cancelarRuta(_ sender: UIButton) {
    }
    
}

//MARK: MQTT Delegate implementation

extension MapController: MQTTSessionDelegate{
    func mqttDidReceive(message data: Data, in topic: String, from session: MQTTSession) {
        let info = String(data: data, encoding: .utf8)!
        print(info)
    }
    
    func mqttDidDisconnect(session: MQTTSession) {
        print("Disconnected")
    }
    
    func mqttSocketErrorOccurred(session: MQTTSession) {
        print("Error!")
    }
}

//MARK: Location Manager Delegate

extension MapController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = manager.location?.coordinate
    }
}

//MARK: Slide Menu Controller Delegate

extension MapController: SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}

//
//  GeocodeViewController.swift
//  MapKitPractice
//
//  Created by chang sic jung on 13/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit
import MapKit

class GeocodeViewController: UIViewController {

    @IBOutlet private var mapView: MKMapView!
    
    @IBAction private func tap(gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: gesture.view)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            print(placeMark)
            
            if error != nil {
                return print(error!.localizedDescription)
            }
            
            guard let address = placeMark?.first,
            let country = address.country,
            let administrativeArea = address.administrativeArea,
            let locality = address.locality,
            let name = address.name
                else { return }
            
            print("터치 좌표 주소")
            print(" \(country), \(administrativeArea), \(locality), \(name)")
        }
    }
}

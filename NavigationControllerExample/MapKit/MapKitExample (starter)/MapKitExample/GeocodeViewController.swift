//
//  GeocodeViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2019. 5. 5..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit
import MapKit

// 

final class GeocodeViewController: UIViewController {

  @IBOutlet private weak var mapView: MKMapView!
  
  @IBAction func recognizeTap(gesture: UITapGestureRecognizer) {
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
        
        print("터치좌표주소")
        print(" \(country) \(administrativeArea) \(locality) \(name)")
        
        //let addr = " \(country) \(administrativeArea) \(locality) \(name)"
        //let addr = "대한민국 서울특별시 동작구 상도동 159-186"
        let changsikHomeAddr = "대한민국 충청북도 청주시 오창읍 창리 160"
        geocoder.geocodeAddressString(changsikHomeAddr, completionHandler: { (placeMark, error) in
            //print(placeMark)
            
            guard let placeMark = placeMark?.first else { return }
            print("\(placeMark.location?.coordinate.latitude), \(placeMark.location?.coordinate.longitude)")
            
        })
    }
    
  }
}

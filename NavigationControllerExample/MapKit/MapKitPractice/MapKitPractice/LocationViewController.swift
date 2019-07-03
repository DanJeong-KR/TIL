//
//  LocationViewController.swift
//  MapKitPractice
//
//  Created by chang sic jung on 11/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

// Annotation 은 MKAnnotation 프로토콜을 채택함.
final class Annotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

final class LocationViewController: UIViewController {
    
    
    @IBOutlet var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        checkAuthorizationStatus()
        print("coordinate :",locationManager.location?.coordinate)
    }
    
    func configure() {
        locationManager.delegate = self
        mapView.showsUserLocation = true
    }
    
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // 위치 서비스가 제한됨, 거부됨
            break
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:

            locationManager.requestAlwaysAuthorization()
            startUpdateLocation()
            
        default:
            break
        }
    }
    
    func startUpdateLocation() {
        let status = CLLocationManager.authorizationStatus()
        guard status == .authorizedAlways || status == .authorizedWhenInUse, CLLocationManager.locationServicesEnabled() else { print("bug");return }
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10.0
        locationManager.startUpdatingLocation()
    }
    
    @IBAction private func monitoringAction(_ sender: UIBarButtonItem) {
        guard CLLocationManager.headingAvailable() else
        { print("heading permission disavailable"); return }
        locationManager.startUpdatingHeading()
    }
    
    @IBAction private func stopMonitoringAction(_ sender: UIBarButtonItem) {
        locationManager.stopUpdatingHeading()
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let current = locations.last! // 하드웨어에서의 위치정보
        
        let coordinate = current.coordinate // 그 위치의 위도 경도 가져오고
        let span = MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        addAnnotation(location: current)
        
    }
    
    func addAnnotation(location: CLLocation) {
        let annotation = Annotation(title: "창식 로케이션", coordinate: location.coordinate)
        mapView.addAnnotation(annotation)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("true Heading : \(newHeading.trueHeading)")
        print("magnetic Heading : \(newHeading.magneticHeading)")
        print("Values : \(newHeading.x), \(newHeading.y), \(newHeading.z)")
    }
}

//
//  MyLocationViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2019. 5. 5..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

final class Annotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}


final class MyLocationViewController: UIViewController {
  
  @IBOutlet private weak var mapView: MKMapView!
  private let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    checkAuthorizationStatus()
    
    mapView.showsUserLocation = true
    //mapView.mapType = .satellite
    
    mapView.showsCompass = true
    
  }
    
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: // 아직 사용자가 결정을 하지 않았을 때 , 허용 메세지를 봐도 홈키로 나간다던지.
            locationManager.requestWhenInUseAuthorization()
            //locationManager.requestAlwaysAuthorization()
        case .restricted, .denied:
            //disable location features
            break
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:
            locationManager.requestAlwaysAuthorization()
            startUpdateLocation()
            print("항상 허용함")
            
        @unknown default:
            break
        }
    }
    
    func startUpdateLocation() {
        let status = CLLocationManager.authorizationStatus()
        guard status == .authorizedAlways || status == .authorizedWhenInUse, CLLocationManager.locationServicesEnabled() else { return }
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10.0
        locationManager.startUpdatingLocation()
    }
  
  @IBAction private func mornitoringHeading(_ sender: Any) {
    
    guard CLLocationManager.headingAvailable()  else { return }
    locationManager.startUpdatingHeading()
    
    }
  
  @IBAction private func stopMornitoring(_ sender: Any) {
    locationManager.stopUpdatingHeading()
  }
}


extension MyLocationViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("\n ------------ [ status ]-----\n")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("허용함")
        default:
            print("허용 안함")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let current = locations.last! // location 이 있어야 이 메소드가 호출되니까 반드시 하나는 있다. ! 써야지!
        
        // 최신 정보를 10초 이내의 것으로
        if (abs(current.timestamp.timeIntervalSinceNow) < 10) {
            let coordinate = current.coordinate // 위경도 값을 가져오고
            
            // span 단위는 1도
            // 경도 1도는 약 111 킬로미터 , 위도 1 도는 위도에 따라 변함.
            // 위도 1도는 위도에 따라 변한다. : 적도 (약 111) ~ 극지방 0km
            // MKCoordinateSpan 이 작을 수록 좁게 보는거고 값이 크면 넓은 범위에서 맵을 본다.
            let span = MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)
            
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            addAnnoTation(location: current)
        }
        
    }
    
    func addAnnoTation(location: CLLocation) {
        let annotation = Annotation(title: "창식 로케이션", coordinate: location.coordinate)
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // 권한을 받지 못할 때
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("tureHeading", newHeading.trueHeading)
        print("magneticHeading", newHeading.magneticHeading)
        print("Values \(newHeading.x), \(newHeading.y), \(newHeading.z)")
        
    }
    
}

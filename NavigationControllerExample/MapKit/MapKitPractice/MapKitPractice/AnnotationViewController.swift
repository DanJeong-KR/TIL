//
//  AnnotationViewController.swift
//  MapKitPractice
//
//  Created by chang sic jung on 13/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit
import MapKit

class AnnotationViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = CLLocationCoordinate2DMake(37.566308, 126.977948)
        setRegion(coordinate: center)
    }
    
    func setRegion(coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction private func addAnnotation(_ sender: UIBarButtonItem) {
        let cityHall = MKPointAnnotation()
        cityHall.title = "시청"
        cityHall.subtitle = "서울 특별시"
        cityHall.coordinate = CLLocationCoordinate2DMake(37.566308, 126.977948)
        
        let changsik = MKPointAnnotation()
        changsik.title = "창식 집"
        changsik.coordinate = CLLocationCoordinate2DMake(36.7386091, 127.4503619)
        mapView.addAnnotations([cityHall,changsik])
    }
    
    @IBAction private func randomAnnotation(_ sender: UIBarButtonItem) {
        guard !mapView.annotations.isEmpty else { return }
        let random = Int.random(in: 0..<mapView.annotations.count)
        let annotation = mapView.annotations[random]
        setRegion(coordinate: annotation.coordinate)
    }
    
    @IBAction private func removeAllAnnotations(_ sender: UIBarButtonItem) {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    @IBAction private func setupCamera(_ sender: UIBarButtonItem) {
        let camera = MKMapCamera()
        camera.centerCoordinate = CLLocationCoordinate2DMake(36.7386091, 127.4503619)
        camera.altitude = 130
        camera.pitch = 60.0
        mapView.setCamera(camera, animated: true)
    }
    
    
}

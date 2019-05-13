//
//  CalloutActionViewController.swift
//  MapKitPractice
//
//  Created by chang sic jung on 13/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

final class annotationInfo: MKPointAnnotation {
    var exhibition: [String]!
    var phoneNumber: String!
    var url: URL!
}

class CalloutActionViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setRegion()
        addAnnotation()
    }
    
    func setRegion() {
        let center = CLLocationCoordinate2DMake(37.5514, 126.9880)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotation() {
        let museum1 = annotationInfo()
        museum1.title = "국립중앙박물관"
        //museum1.subtitle = "국립중앙박물관11"
        museum1.coordinate = CLLocationCoordinate2DMake(37.523984, 126.980355)
        museum1.phoneNumber = "02-2077-9000"
        museum1.exhibition = ["고려 건국 1100주년", "칸의 제국 몽골", "외규장각 의궤"]
        museum1.url = URL(string: "http://www.museum.go.kr")!
        
        let museum2 = annotationInfo()
        museum2.title = "세종문화회관"
        museum2.subtitle = "세종문화회관11"
        museum2.coordinate = CLLocationCoordinate2DMake(37.572618,126.975203)
        museum2.phoneNumber = "02-399-1000"
        museum2.exhibition = ["2018 그랜드 Summer 클래식", "사랑의 묘약"]
        museum2.url = URL(string: "http://www.sejongpac.or.kr")!
        
        mapView.addAnnotations([museum1, museum2])
    }

}


extension CalloutActionViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? annotationInfo else { return nil }
        
        var annotationView: MKAnnotationView
        
        if let reusableView = mapView.dequeueReusableAnnotationView(withIdentifier: "MuseumID") { // nil 이 아니면 재생성 안해도 되면
            reusableView.annotation = annotation
            annotationView = reusableView
        }else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "MuseumID")
            annotationView.image = UIImage(named: "museum")
            annotationView.canShowCallout = true
            
            let addButton = UIButton(type: .contactAdd)
            addButton.tag = 0
            annotationView.leftCalloutAccessoryView = addButton
            
            let infoButton = UIButton(type: .infoDark)
            infoButton.tag = 1
            annotationView.rightCalloutAccessoryView = infoButton
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? annotationInfo else { return }
        print("AnnotationInfo: \(annotation.title!), tag: \(control.tag)")
        
        if control.tag == 1 {
            let safariVC = SFSafariViewController(url: annotation.url)
            present(safariVC, animated: true)
        }
    }
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        guard let annotation = view.annotation as? annotationInfo else { return }
//        print("Annotation Info: \(annotation.title!), \(annotation.exhibition!), \(annotation.phoneNumber!)")
//    }
//
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let museum = view.annotation as? annotationInfo else { return }
//        print("museum Info: \(museum.title!), tag :\(control.tag)")
//
//        if control.tag == 1 {
//            let safariVC = SFSafariViewController(url: museum.url)
//            present(safariVC, animated: true)
//        }
//    }
}

/*
[ 과제 ]
1. 입력한 주소들을 차례대로 잇는 선 만들기   (샘플 영상 참고)
> 텍스트필드에 주소를 입력하면 해당 위치로 애니메이션과 함께 맵 이동 (CoordinateSpan 값 - 0.02)
> 입력한 주소값으로 이동한 뒤 그 위치를 표시하기 위한 사각형 그리기 + Annotation 추가하기
> Annotation 의 제목은 1번째 행선지, 2번째 행선지 처럼 순서를 표시하고, 부제목은 그 곳의 주소 나타내기
> 마지막으로 입력한 주소값과 그 직전의 주소값 사이에 선 그리기
(가장 처음 입력한 주소는 그것과 연결할 직전의 주소값이 없으므로 제외)
*/

import UIKit
import MapKit

final class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

class ViewController: UIViewController {
    
    private var locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    private var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "장소를 입력하세요"
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.boldSystemFont(ofSize: 25)
        textField.textAlignment = .center
        return textField
    }()
    
    private var annotationArr: [Annotation] = [] {
        didSet {
            mapView.addAnnotation(self.annotationArr.last!)
        }
    }
    
    private var pathPoints: [CLLocationCoordinate2D] = [] {
        didSet {
            if self.pathPoints.count >= 2 {
                let points = [self.pathPoints[self.pathPoints.count - 1], self.pathPoints[self.pathPoints.count - 2]]
                let polyline = MKPolyline(coordinates: points, count: points.count)
                mapView.addOverlay(polyline)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        autoLayout()
        checkAuthorizationStatus()
    }
    
    func configure() {
        view.addSubview(mapView)
        view.addSubview(textField)
        
        textField.delegate = self
        mapView.delegate = self
    }
    
    // autoLayout
    func autoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 60),
            
            mapView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
            
            ])
    }
    
    // MARK: - 위치서비스 권한에 따라서!
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            break
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func setRegion(coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        geocoder.geocodeAddressString(textField.text ?? "") { (placeMark, error) in
            guard let placemark = placeMark?.first,
            let coordinate = placemark.location?.coordinate
                else { print("haha"); return }
            
            self.pathPoints.append(coordinate) // 경로 표시하기 위해
        
            let annotation = Annotation(title: "\(self.annotationArr.count + 1)번째 행선지", coordinate: coordinate)
            self.annotationArr.append(annotation)
            
            self.addRectPolyline(center: coordinate)
            self.setRegion(coordinate: coordinate)
        }
        
        return true
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func addRectPolyline(center: CLLocationCoordinate2D) {
        
        var point1 = center; point1.latitude += 0.001; point1.longitude -= 0.001
        var point2 = center; point2.latitude += 0.001; point2.longitude += 0.001
        var point3 = center; point3.latitude -= 0.001; point3.longitude += 0.001
        var point4 = center; point4.latitude -= 0.001; point4.longitude -= 0.001
        
        let points = [point1, point2, point3, point4, point1]
        
        let polyline = MKPolyline(coordinates: points, count: points.count)
        mapView.addOverlay(polyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let rect = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: rect)
            renderer.strokeColor = .red
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}


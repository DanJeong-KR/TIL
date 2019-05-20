
import UIKit
import MapKit

class RendererOverlayViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    
    @IBAction private func addCircle(_ sender: UIBarButtonItem) {
        let center = mapView.centerCoordinate
        let circle = MKCircle(center: center, radius: 2000)
        mapView.addOverlay(circle)
    }
    
    @IBAction private func addStarInMyHome(_ sender: Any) {
        let center = CLLocationCoordinate2DMake(36.7386091, 127.4503619)
        
        var point1 = center; point1.latitude += 0.60
        var point2 = center; point2.longitude -= 0.45 ; point2.latitude -= 0.3
        var point3 = center; point3.longitude += 0.45 ; point3.latitude -= 0.3
        
        let points: [CLLocationCoordinate2D] = [point1, point2, point3, point1]
        let polyLine = MKPolyline(coordinates: points, count: points.count)
        mapView.addOverlay(polyLine)
    }
    
    @IBAction private func removeAllOverays(_ sender: Any) {
        mapView.removeOverlays(mapView.overlays)
    }
}

extension RendererOverlayViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = .red
            renderer.lineWidth = 2
            return renderer
        }
        
        if let home = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: home)
            renderer.strokeColor = .blue
            renderer.lineWidth = 2
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
}



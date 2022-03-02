//
//  ThirdViewController.swift
//  week07
//
//  Created by Hümeyra Şahin on 1.03.2022.
//

import UIKit
import MapKit
class ThirdViewController: UIViewController {
    
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var mapKit: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureRecognizer()
    }
    
    func gestureRecognizer(){
        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(handleLongGesture(_ :)))
        self.view.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongGesture(_ sender: UILongPressGestureRecognizer){
        let point = sender.location(in: mapKit)
        let coordinate = mapKit.convert(point, toCoordinateFrom: mapKit)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "My Adress"
        
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                print("Hata: \(error)")
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            let city = placemark.locality ?? ""
            let street = placemark.thoroughfare ?? ""
            let sublocality = placemark.subLocality ?? ""
            let postalcode = placemark.postalCode ?? ""
            let country = placemark.country ?? ""
            self.adressLabel.text = " \(street), \(sublocality), \(city), \(country),  \(postalcode)"
        }
        if !mapKit.annotations.isEmpty {
            mapKit.removeAnnotations(mapKit.annotations)
        }
        mapKit.addAnnotation(annotation)
    }
}

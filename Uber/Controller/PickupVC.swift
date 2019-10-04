//
//  PickupVC.swift
//  Uber
//
//  Created by MD RASHEDUZZAMAN on 30/05/19.
//  Copyright © 2019 MD RASHEDUZZAMAN. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class PickupVC: UIViewController {
    
    var pickupCoordinate: CLLocationCoordinate2D!
    var passengerKey: String!
    
    var regionRadius: CLLocationDistance = 2000
    var pin: MKPlacemark? = nil
    
    var locationPlacmark: MKPlacemark!
    
    @IBOutlet weak var pickupMapView: RoundedMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickupMapView.delegate = self
        locationPlacmark = MKPlacemark(coordinate: pickupCoordinate)        
        dropPinFor(placemark: locationPlacmark)
        centerMapOnLocation(location: locationPlacmark.location!)
        
        DataService.instance.REF_TRIPS.child(passengerKey).observe(.value, with: { (tripSnapshot) in
            if tripSnapshot.exists() {
                if tripSnapshot.childSnapshot(forPath: "tripIsAccepted").value as? Bool == true {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    func initData(coordinte: CLLocationCoordinate2D, passengerKey: String){
        self.pickupCoordinate = coordinte
        self.passengerKey = passengerKey
    }

    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func acceptTripBtnWasPressed(_ sender: Any) {
        let currentUserID = Auth.auth().currentUser?.uid
        UpdateService.instance.acceptTrip(withPassengerKey: passengerKey, forDriverKey: currentUserID!)
        presentingViewController?.shouldPresentLoadingView(true)
    }
}

extension PickupVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pickupPoint"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "destinationAnnotation")
        return annotationView
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        pickupMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func dropPinFor(placemark: MKPlacemark){
        pin = placemark
        
        for annotation in pickupMapView.annotations {
            pickupMapView.removeAnnotation(annotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        
        pickupMapView.addAnnotation(annotation)
    }
}

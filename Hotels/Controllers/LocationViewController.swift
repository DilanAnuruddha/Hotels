//
//  LocationViewController.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    var hotel: HotelViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addLocationToMap()
    }
    
    //MARK: Components
    let mapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.showsCompass = true
        map.isPitchEnabled = true
        map.isRotateEnabled = true
        return map
    }()
    
    //MARK: Setup UI
    func setupView()  {
        view.addSubViews(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: Functions
extension LocationViewController {
    
    //Configure the navigation Bar
    fileprivate func configNavBar(){
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        navigationItem.title = "Location"
    }
    
    //Add annotation with details
    fileprivate func addLocationToMap(){
        if let latitude =  Double(hotel?.latitude ?? "0"), let longitude = Double(hotel?.longitude ?? "0") {
            let coordinate:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
            mapView.centerToLocation(coordinate)
            
            //Add Annotation
            let locAnnotation = MKPointAnnotation()
            locAnnotation.title = hotel?.title
            locAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.addAnnotation(locAnnotation)
        }
    }
}

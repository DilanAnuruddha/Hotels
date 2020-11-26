//
//  Extensions.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import Foundation
import UIKit
import MapKit

extension UIView {
    //Add multiple views and ready to set autolayout constraints.
    func addSubViews(_ views:UIView...) {
        views.forEach({
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
}

//MARK: UIViewController
extension UIViewController {
    
    //Add indicater view with bacground and start animations.
    func addLoaderToView(view:UIView,loader:UIActivityIndicatorView,loaderBackground:UIView) {
        DispatchQueue.main.async {
            view.addSubViews(loaderBackground)
            loaderBackground.translatesAutoresizingMaskIntoConstraints = false
            loaderBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loaderBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            let width = UIDevice.current.userInterfaceIdiom == .pad ? 0.1 : 0.3
            loaderBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(width)).isActive = true
            loaderBackground.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(width)).isActive = true

            loaderBackground.addSubview(loader)
            loader.translatesAutoresizingMaskIntoConstraints = false
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

            loader.isHidden = false
            loader.startAnimating()
        }
    }

    //Stop animations and remove the indicator view
    func removeLoader(loader:UIActivityIndicatorView,loaderBackground:UIView) {
        DispatchQueue.main.async {
            loader.stopAnimating()
            loader.isHidden = true
            loaderBackground.removeFromSuperview()
        }
    }
}

extension UIImageView {
    //Download the image async & set it to imageView
    func setImage(url: URL) {
        let task = URLSession.shared.dataTask(with: url){ (data , response , error) in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

extension MKMapView {
    //Map recenter to the location
    func centerToLocation(_ location: CLLocation, regionRadius : CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion (
            center : location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        
        setRegion(coordinateRegion, animated: true)
    }
}

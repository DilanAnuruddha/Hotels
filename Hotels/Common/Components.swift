//
//  Components.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import Foundation
import UIKit

class Components {
    
    //MARK: Indicatorview UI Component set
    static func getLoaderViewSet()->(UIActivityIndicatorView,UIView) {
        //Indicator View
        let loader = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            loader.style = UIActivityIndicatorView.Style.large
            loader.color = .systemBackground
        } else {
            loader.style = UIActivityIndicatorView.Style.white
            loader.color = .white
        }
        
        //loader background
        let view = UIView()
        view.backgroundColor = UIColor(named: "systemColor_inverse")?.withAlphaComponent(0.8)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10

        return (loader,view)
    }
}

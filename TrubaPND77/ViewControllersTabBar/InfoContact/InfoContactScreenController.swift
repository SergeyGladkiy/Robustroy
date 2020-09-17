//
//  InfoContactScreenController.swift
//  TrubaPND77
//
//  Created by Serg on 17.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import UIKit
import MapKit

class InfoContactScreenController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        mapView.delegate = self
        mapView.layer.cornerRadius = 5
        mapView.layer.masksToBounds = true
        
        let coordinates = CLLocationCoordinate2D(latitude: 55.656626, longitude: 37.256198)
        let mapPin = MapPin(coordinate: coordinates, title: "ТрубаПНД77", subtitle: nil)
        
        self.mapView.addAnnotation(mapPin)
        
        settingMapRect()
    }
    
    private func settingMapRect() {
        var zoomRect = MKMapRect.null
        
        for annotation in mapView.annotations {
            let location = annotation.coordinate
            let center = MKMapPoint(location)
            let delta: Double = 4000
            let rect = MKMapRect(x: center.x - delta, y: center.y - delta, width: 2*delta, height: 2*delta)
            zoomRect = zoomRect.union(rect)
        }
        zoomRect = mapView.mapRectThatFits(zoomRect)
        mapView.setVisibleMapRect(zoomRect, edgePadding: .init(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }

    @IBAction func tapOnLink(_ sender: UIButton) {
        if let url = URL(string: (sender.titleLabel?.text)!) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func tapOnTelephone(_ sender: UIButton) {
        guard
            let phoneNumber = sender.titleLabel?.text,
            let url = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url)
            else {
            objectDescription(self, function: #function)
            return
        }
        UIApplication.shared.open(url)
    }
    
}

extension InfoContactScreenController: MKMapViewDelegate {
    
}

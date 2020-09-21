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
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        settingMapView()
        addCoordinateCompany(title: "Robustрой", lat: 55.659910, lon: 37.260872)
        addCoordinateCompany(title: "TрубаПНД77", lat: 55.657829, lon: 37.257575)
        settingMapRect()
    }
    
    fileprivate func settingMapView() {
        mapView.delegate = self
        mapView.layer.cornerRadius = 5
        mapView.layer.masksToBounds = true
    }
    
    fileprivate func addCoordinateCompany(title: String, lat: Double, lon: Double) {
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let mapPin = MapPin(coordinate: coordinates, title: title, subtitle: nil)
        
        self.mapView.addAnnotation(mapPin)
    }
    
    private func settingMapRect() {
        var zoomRect = MKMapRect.null
        
        for annotation in mapView.annotations {
            let location = annotation.coordinate
            let center = MKMapPoint(location)
            let delta: Double = 7000
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
    @IBAction func tapOnLinkSecond(_ sender: UIButton) {
        if let url = URL(string: (sender.titleLabel?.text)!) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func tapOnTelephone(_ sender: UIButton) {
        canOpenUrlTelephone(sender)
    }
    
    @IBAction func tapOnTelephoneSecond(_ sender: UIButton) {
        canOpenUrlTelephone(sender)
    }
    
    private func canOpenUrlTelephone(_ sender: UIButton) {
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

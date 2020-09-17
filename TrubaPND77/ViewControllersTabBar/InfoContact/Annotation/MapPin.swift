//
//  MyCoordinate.swift
//  TrubaPND77
//
//  Created by Serg on 17.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import MapKit

class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}


//class CoordinatesCredential: NSObject {
//
//}
//
//extension CoordinatesCredential: MKAnnotation {
//    var CoordinatesCredential: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: 55.656626, longitude: 37.256198)
//    }
//}

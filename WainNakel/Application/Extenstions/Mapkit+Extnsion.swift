//
//  Mapkit+Extnsion.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 1441 yoma. All rights reserved.
//

import Foundation
import MapKit

final class Annotation: NSObject,MKAnnotation{
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(restaurant: RestaurantModel, location: CLLocationCoordinate2D){
        self.coordinate = location
        self.title = restaurant.name
        self.subtitle = restaurant.cat
    }
}

extension MKMapView{
    func markPin(restaurant: RestaurantModel, latDetail: CLLocationDegrees = 0.005, longDetail: CLLocationDegrees = 0.005) -> MKAnnotation?{
        if let lat = Double(restaurant.lat ?? ""), let long = Double(restaurant.lon ?? ""){
            let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
            setRegion(MKCoordinateRegion(center: center, latitudinalMeters: latDetail, longitudinalMeters: longDetail), animated: true)
            return Annotation(restaurant: restaurant, location: center)
        }
        return nil
    }
}

//
//  MapViewModel.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 15/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit
import CoreLocation

final class MapViewModel: BaseViewModel {
        
    func configureLocation() -> Void {
        configureLocation(self)
    }
    
    func getRandomRestaurant(_ location: CLLocationCoordinate2D) -> Void {
        RestaurantModel.getRandomRestaurant(location) { (response) in
            switch response{
            case .success(let object):
                break
            case .failure(let error, let params):
                self.view?.didFailWithError(error.getError(params))
            case .networkError(let error):
                self.view?.didFailWithNetworkError(error, completion: {
                    self.getRandomRestaurant(location)
                })
            }
        }
    }
    
}

extension MapViewModel: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations[locations.count - 1]
        getRandomRestaurant(location.coordinate)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .restricted, .denied, .notDetermined:
            self.view?.alert(title: "التطبيق لا يملك صلاحية الوصول للموقع", buttonTitle: "الاعدادات", body: "يرجى اعطاء صلاحية الوصول للموقع من الاعدادات", completion: {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: nil)
                }
            })
        default: break
        }
    }
}

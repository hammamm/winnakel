//
//  MapViewModel.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 15/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit
import CoreLocation

class MapViewModel: BaseViewModel {
    
    var view: MapViewProtocol?
    let locationManager = CLLocationManager()
    var lastLocation: CLLocationCoordinate2D?

    var restuarnat: RestaurantModel?{
        didSet{
            view?.refreshUi()
        }
    }
    
    func configureLocation(_ delegate: CLLocationManagerDelegate) -> Void {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = delegate
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied, .notDetermined:
                self.view?.alert(title: "التطبيق لا يملك صلاحية الوصول للموقع", buttonTitle: "الاعدادات", body: "يرجى اعطاء صلاحية الوصول للموقع من الاعدادات", completion: {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    }
                })
            default: break
            }
        } else {
            self.view?.alert(title: "التطبيق لا يملك صلاحية الوصول للموقع", buttonTitle: "الاعدادات", body: "يرجى اعطاء صلاحية الوصول للموقع من الاعدادات", completion: {
                if #available(iOS 13, *) {
                    guard let settingsUrl = URL(string: "App-prefs:LOCATION_SERVICES") else { return }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    }
                }else{
                    guard let settingsUrl = URL(string: "prefs:LOCATION_SERVICES") else { return }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    }
                }
            })
        }
    }

    func configureLocation() -> Void {
        configureLocation(self)
    }
    
    func getRandomRestaurant(_ location: CLLocationCoordinate2D) -> Void {
        view?.loading(true)
        RestaurantModel.getRandomRestaurant(location) { (response) in
            self.view?.loading(false)
            switch response{
            case .success(let object):
                self.restuarnat = object
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

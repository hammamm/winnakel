//
//  BaseViewModel.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 15/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit
import CoreLocation

class BaseViewModel: NSObject {
    
    let locationManager = CLLocationManager()
    var lastLocation: CLLocationCoordinate2D?
    weak var view: BaseViewProtocol?
    
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
}

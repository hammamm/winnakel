//
//  Router+Activities.swift
//
//  Created by hammam abdulaziz on 04/05/1441 AH.
//  Copyright © 1441 randomQuote. All rights reserved.
//

import Foundation
import CoreLocation

extension Router {
    
    enum RestaurantRouter: MyEndpoint {
        
        case getRandomRestaurant(location: CLLocationCoordinate2D)
        
        var serviceUrl: String {
            switch self {
            case .getRandomRestaurant(let location):
                return Keys.Api.getRandomRestaurant + "?uid=\(location.longitude.description),\(location.latitude.description)&get_param =value"
            }
        }

        var parameters: [String : Any]? {
            switch self {
            case .getRandomRestaurant:
                return nil
            }
        }

        var method: HTTPMethod{
            switch self {
            case .getRandomRestaurant:
                    return .get
            }
        }
    }
}

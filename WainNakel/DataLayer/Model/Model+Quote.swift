//
//  Model+Quote.swift
//  QuoteApp
//
//  Created by hammam abdulaziz on 05/11/1441 AH.
//  Copyright © 1441 randomQuote. All rights reserved.
//

import Foundation
import CoreLocation

typealias Location = (lat: String, long: String)
// MARK: - RestaurantModel
class RestaurantModel: Codable {
    let error, name, id: String
    let link: String
    let cat, catId, rating, lat: String
    let lon, Ulat, Ulon, welcomeOpen: String
    let image: [String]
}

extension RestaurantModel{
    var rateAndCat: String{
        cat + " - " + rating + "/" + "10"
    }
    
    var location: Location{
        return (lat, lon)
    }
}

extension RestaurantModel{
    static func getRandomRestaurant(_ location: CLLocationCoordinate2D, completion: @escaping Response<RestaurantModel,ModelError<MultiError>>) -> Void {
        _getRandomRestaurant(location: location) { (response) in
            switch response{
            case .success(let model):
                completion(.success(model))
            case .failure(let error, let params):
                completion(.failure(error, params))
            case .networkError(let error):
                completion(.networkError(error))
            }
        }
    }
    
    private static func _getRandomRestaurant(location: CLLocationCoordinate2D, completion: @escaping Response<RestaurantModel,ModelError<MultiError>>) -> Void {
        Router.RestaurantRouter.getRandomRestaurant(location: location).request(completion: completion)
    }
}

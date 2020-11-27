//
//  Model+Error.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import Foundation

struct ModelError<T: Codable> : Codable {
    let status: Int?
    let message: T
    let data: [String?]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}

extension ModelError: Error, LocalizedError {
        
    func errorDescription(_ key: String? = nil) -> String {
        // cast the laravel error wich some time return a message of object no string
        if let key = key {
            if let object = message as? [String: Any], let errorMessage = object[key] as? [String]{
                return errorMessage.first ?? localizedDescription
            }else if let object = message as? [String: Any], let errorMessage = object[key] as? String{
                return errorMessage
            }else{
                return localizedDescription
            }
        }else{
            if let errorMessage = message as? String{
                return errorMessage
            }else{
                return localizedDescription
            }
        }
    }
}

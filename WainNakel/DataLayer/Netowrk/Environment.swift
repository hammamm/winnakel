//
//  Environment.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.
//

import Foundation

enum Environment {
    
    case production
    case development
    
    static var baseURL: String {
        return Environment.current == production ? production.url : development.url
    }
    
    static var current: Environment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
    
    private var url: String {
        switch self {
        case .production:
            return "https://wainnakel.com/api/v1/"
        case .development:
            return "https://wainnakel.com/api/v1/"
        }
    }
}

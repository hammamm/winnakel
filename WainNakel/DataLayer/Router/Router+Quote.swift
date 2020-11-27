//
//  Router+Activities.swift
//
//  Created by hammam abdulaziz on 04/05/1441 AH.
//  Copyright © 1441 randomQuote. All rights reserved.
//

import Foundation

extension Router {
    
    enum QuoteRouter: MyEndpoint {
        
        case getRandomQuote
        
        var serviceUrl: String {
            switch self {
            case .getRandomQuote:
                return Url.getRandomQuote
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case .getRandomQuote:
                return nil
            }
        }
        
        var method: HTTPMethod{
            switch self {
            case .getRandomQuote:
                    return .get
            }
        }
        
    }
}

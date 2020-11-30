//
//  MyApi.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit

class MyApi {
    
    static func request<T: Decodable,E: Codable>(url: String,
                                      headers: [String: String]? = nil,
                                      httpMethod: HTTPMethod,
                                      parameters: [String: Any]? = nil,
                                      node: String?,
                                      isPrintable: Bool,
                                      images: [(image: UIImage, name: String)]? = nil,
                                      completion: @escaping Response<T,E>
    ) {
        
        NetworkService.request(url: url, headers: headers, httpMethod: httpMethod, parameters: parameters, isPrintable: isPrintable) { (result) in
            switch result {
            case .success(let data):
                do {
                    let data = try JSONSerialization.jsonObject(with: data, options: [])
                    let dictionary = data as? [String: Any]
//                    let code = dictionary?["status"] as? Int
//                    guard code == 200 else {
//                        let json = try JSONSerialization.data(withJSONObject: dictionary as Any, options: .prettyPrinted)
//                        let jsonDecoder = JSONDecoder()
//                        let error = try jsonDecoder.decode(E.self, from: json)
//                        completion(.failure(error, parameters?.getKeys))
//                        // here if i want to handle some errors api like delete current user info
//                        return
//                    }
                    
                    let node = node != nil ? dictionary?[node ?? ""] : dictionary
                    let json = try JSONSerialization.data(withJSONObject: node as Any, options: .prettyPrinted)
                    let object = try JSONDecoder().decode(T.self, from: json)
                    completion(.success(object))
                } catch let error {
                    // return decoding failed
                    logNetwork("❌ Error in Mapping\n\(url)\nError:\n\(error)")
                }
            case .failure(let error):
                completion(.networkError(error))
            }
        }
    }
}

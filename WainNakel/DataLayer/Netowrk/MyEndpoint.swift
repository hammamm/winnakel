//
//  MyEndpoint.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.
//

import UIKit

protocol MyEndpoint: Endpoint { }

extension MyEndpoint {
    
    /// Base url with serviceUrl
    var url: String {
        return serviceUrl.hasPrefix("http") ? serviceUrl : (Environment.baseURL + serviceUrl)
    }
    
    /// Base headers for every request
    var defaultHeaders: [String: String] {
        let header: [String: String] = [:]
        var allHeaders = headers ?? [String: String]()
        // add default headers to header
        allHeaders += header
        return allHeaders
    }
    
    /// Default parameters for your endpoint
    var defaultParameters: [String: Any] {
        let params: [String: Any] = [:]
        var allParameters = parameters ?? [String: Any]()
        // add default parameters to params
        allParameters += params
        return allParameters
    }
    
    /// headers is nil because we have `defaultHeaders` and if you want to add more you
    /// can override this `headers` in your endpoint router if you need, and if you want
    /// a new headers without `defaultHeaders` you can override `defaultHeaders` in your router
    var headers: [String: String]? {
        return nil
    }
    
    /// Default method for your endpoints, override it in your endpoint router if need it
    var method: HTTPMethod {
        return .get
    }
        
    var isPrintable: Bool {
        return true
    }
    
    var node: String? {
        return nil
    }
}

extension MyEndpoint {
    
    /// Request method for every endpoint
    ///
    /// - Parameter completion: Response<T>
    ///
    /// - Author: hammam abdulaziz
    func request<T: Codable,E: Codable>(completion: @escaping Response<T,E>) {
        MyApi.request(url: url,
                      headers: defaultHeaders,
                      httpMethod: method,
                      parameters: defaultParameters,
                      node: node,
                      isPrintable: isPrintable,
                      completion: completion)
    }
}


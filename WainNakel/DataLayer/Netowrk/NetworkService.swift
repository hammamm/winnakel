//
//  NetworkService.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.
//

import Foundation

enum NetworkResponse {
    case success(Data)
    case failure(NSError)
}

class NetworkService {
    
    static func request(url: String,
                        headers: [String: String]? = nil,
                        httpMethod: HTTPMethod,
                        parameters: [String: Any]? = nil,
                        isPrintable: Bool,
                        completion: @escaping (NetworkResponse) -> Void) {
        
        let date = Date()
        logNetwork("""
            🙇‍♂️ \(httpMethod.rawValue.uppercased()) '\(url)':
            📝 Request headers = \(headers?.json ?? "No Headers")
            📝 Request Body = \(parameters?.json ?? "No Parameters")
            """ )
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        if var url = URLComponents(string: url), let parameters = parameters{
            var items = [URLQueryItem]()
            for (key,value) in parameters {
                items.append(URLQueryItem(name: key, value: "\(value)"))
            }
            url.queryItems = items
            if let url = url.url{
                var request = URLRequest(url: url)
                request.httpMethod = httpMethod == .get ? "GET" : "POST"
                request.allHTTPHeaderFields = headers
                dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
                    defer {
                        dataTask = nil
                    }
                    if let error = error {
                        completion(.failure(error as NSError))
                        if let httpResponse = response as? HTTPURLResponse {
                            logNetwork("""
                                ❌ Error in response: \(request.httpMethod?.uppercased() ?? "") '\(url)' (\(httpResponse.statusCode)):
                                ❌ Error: \(error)
                                ⬇️ Response headers = \(
                                request.allHTTPHeaderFields?.json ?? "No Headers")
                                """)
                        }
                    } else if
                        let data = data,
                        let response = response as? HTTPURLResponse{
                        // 6
                        DispatchQueue.main.async {
                            completion(.success(data))
                            if isPrintable {
                                logNetwork("""
                                    ✅ Response: \(request.httpMethod?.uppercased() ?? "") '\(url)':
                                    🧾 Status Code: \(response.statusCode), 💾 \(data), ⏳ time: \(Date().timeSince(date))
                                    ⬇️ Response headers = \(request.allHTTPHeaderFields?.json ?? "No Headers")
                                    ⬇️ Response Body = \(String(data: data, encoding: String.Encoding.utf8) ?? "")
                                    """ )
                            }
                        }
                    }
                }
            }
            dataTask?.resume()
        }
    }
}

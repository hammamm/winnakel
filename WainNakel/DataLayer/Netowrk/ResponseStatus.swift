//
//  ResponseStatus.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.
//

import Foundation

typealias Response<T: Decodable,E: Codable> = (ResponseStatus<T,E>) -> Void

class Paging<T: Codable>: Codable{
    var current_page: Int
    var data: [T]
    let first_page_url: String
    var from, to: Int?
    var last_page: Int
    let last_page_url: String
    let next_page_url: String?
    let path: String
    let per_page: Int
    let prev_page_url: String?
    let total: Int
    
    var getNextPage: Int?{
        return  last_page > current_page ? current_page + 1 : nil
    }
    
    func insert(model: Paging<T>) -> Void {
        data.insert(contentsOf: model.data, at: data.count)
        last_page = model.last_page
        current_page = model.current_page
    }
}

enum ResponseStatus<T: Decodable,E: Codable> {
    case success(T)
    case failure(E,[String]?)
    case networkError(NSError)
}


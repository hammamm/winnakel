//
//  Model+Quote.swift
//  QuoteApp
//
//  Created by hammam abdulaziz on 05/11/1441 AH.
//  Copyright © 1441 randomQuote. All rights reserved.
//

import Foundation

class QuoteModel: Codable {
    var id, en, author: String
    
    init(id: String, en: String, author: String) {
        self.id = id
        self.en = en
        self.author = author
    }
}

extension QuoteModel{
    var getQuote: String{
        return "Quote: \n\n" + en
    }
    
    var getAuthor: String{
        return "Author: " + author
    }
}

extension QuoteModel{
    static func getRandomQuote(_ completion: @escaping Response<QuoteModel,None>) -> Void {
        _getRandomQuote() { (response) in
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
    
    private static func _getRandomQuote(_ completion: @escaping Response<QuoteModel,None>) -> Void {
        Router.QuoteRouter.getRandomQuote.request(completion: completion)
    }
}

//
//  WebService.swift
//  CryptoCrazyRxMVVM
//
//  Created by Onur Bulut on 24.09.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
    
}

class WebService{
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> ())  {
        
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            if let error = error  {
                completion(.failure(.serverError))
                return
            }
            
            if let data = data {
                
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                    return
                }
            }
            
            completion(.failure(.parsingError))
            
            
        }.resume()
    }
}

//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Nhung Tran on 15/11/2024.
//

import Foundation


class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetch<T: Decodable>(
        from urlString: String,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkErrorEnum>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let networkError = error as NSError?, networkError.domain == NSURLErrorDomain {
                 completion(.failure(.noInternetConnection))
                 return
             }
            else if let error = error {
                completion(.failure(.custom(message: error.localizedDescription)))
                return
            }
            
            // Check if data is valid
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Decode the data
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                print("Failed to decode data. Error: \(error)")
                if let rawData = String(data: data, encoding: .utf8) {
                   print("Raw JSON Response: \(rawData)")
                }
                completion(.failure(.decodingError))


            }
        }.resume()
    }
}

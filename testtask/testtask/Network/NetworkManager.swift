//
//  APICaller.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import Foundation
import Alamofire

enum NetworkManagerErrorType: Error {
    case wrongDecoding
    case missingData
}

class NetworkManager {
    static let shared = NetworkManager()
        
    private init() {}
    
    private let defaultURLString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
// Better do URLBuilder, but app is simple
//    func fetchData<T: Decodable>(type: T.Type, with urlString: String completion: @escaping (Result<T, NetworkManagerErrorType>) -> Void) {
//
//    }
    
    func fetchData<T: Decodable>(type: T.Type, completion: @escaping (Result<T, NetworkManagerErrorType>) -> Void) {
        AF.request(defaultURLString).responseJSON { response in
            guard let rawData = response.data else {
                completion(.failure(.missingData))
                return
            }
            do {
                let cocktailsData = try JSONDecoder().decode(T.self, from: rawData)
                DispatchQueue.main.async {
                    completion(.success(cocktailsData))
                }
            } catch {
                completion(.failure(.wrongDecoding))
            }
        }
    }
}

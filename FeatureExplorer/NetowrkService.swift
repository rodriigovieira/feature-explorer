//
//  File.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 11/04/22.
//

import Foundation
import Combine

struct NetworkService {
    static let shared = NetworkService()
    
    private func fetchDrinksFromApi(urlString: String) -> Future<[DrinkModel], Error> {
        return Future { promise in
            let session = URLSession(configuration: .default)
            let url = URL(string: urlString)
            if let url = url {
                session.dataTask(with: url) { data, _, error in
                    if (error != nil) {
                        return promise(.failure(error!))
                    }
                    
                    if let safeData = data {
                        do {
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(
                                Response.self, from: safeData
                            ).drinks
                            
                            if let safeResponse = response {
                                return promise(.success(safeResponse))
                            }
                        } catch {
                            return promise(.failure(error))
                        }
                    }
                }.resume()
            }
        }
        
    }
    
    func fetchLatestCocktails() -> Future<[DrinkModel], Error> {
        return fetchDrinksFromApi(urlString: ApiURLs.recentDrinks)
    }
    
    func fetchPopularCocktails() -> Future<[DrinkModel], Error> {
        return fetchDrinksFromApi(urlString: ApiURLs.popularDrinks)
    }
}

//
//  NetworkManager.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 02.07.24.
//

import Foundation

enum Link {
    case recipesURL(offset: Int, number: Int)
    case recipeDetailsURL(recipeID: Int)
    case ingredientImageURL(imageName: String)
    
    private var apiKey: String {
        "6422cff154a64782a341a0356afd3ec6"
    }
    
    var url: URL {
        switch self {
        case .recipesURL(let offset, let number):
            return URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&addRecipeInformation=true&offset=\(offset)&number=\(number)")!
        case .recipeDetailsURL(let id):
            return URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=\(apiKey)")!
        case .ingredientImageURL(let imageName):
            return URL(string: "https://img.spoonacular.com/ingredients_100x100/\(imageName)")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

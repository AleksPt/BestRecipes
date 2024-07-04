//
//  NetworkManager.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 02.07.24.
//

import Foundation

enum APIEndpoint {
    
    enum link {
        case base
        case info
        case ingredients
        case instructions
        
        var url: String {
            switch self {
            case .base:
                "https://api.spoonacular.com/recipes/complexSearch?"
            case .info:
                "addRecipeInformation=true"
            case .instructions:
                "addRecipeInstructions=true"
            case .ingredients:
                "fillIngredients=true"
            }
        }
    }
    
    case recipesURL(offset: Int, query: String)
    case popularRecipesURL(offset: Int)
    case cuisineSortedRecipesURL(offset: Int, cuisine: String)
    case ingredientImageURL(imageName: String)

    private var baseURL: String {
        "\(link.base.url)\(link.info.url)&\(link.ingredients.url)&\(link.instructions.url)"
    }
    
    private var apiKey: String {
        ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    }

    var url: URL {
        switch self {
        case .recipesURL(let offset, let query):
            return URL(string: "\(baseURL)&apiKey=\(apiKey)&offset=\(offset)&query=\(query)")!
        case .popularRecipesURL(let offset):
            return URL(string: "\(baseURL)&apiKey=\(apiKey)&offset=\(offset)&sort=popularity")!
        case .cuisineSortedRecipesURL(let offset, let cuisine):
            return URL(string: "\(baseURL)&apiKey=\(apiKey)&offset=\(offset)&cuisine=\(cuisine)")!
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

// Пример использования методов во ViewController

//    private func setupRecipeImage() {
//
//        // для загрузки картинки рецепта, используя Kingfisher
//
//        guard let url = dataStore.recipes.first?.imageURL else { return }
//        recipeImage.getImage(from: url)
//
//        // для загрузки картинки ингредиента, используя URLSession
//
////        guard let url = dataStore.recipes.first?.extendedIngredients?.last?.fullImageURL else { return }
////
////        networkManager.fetchImage(from: url) { [unowned self] result in
////            switch result {
////            case .success(let image):
////                recipeImage.image = UIImage(data: image)
////            case .failure(let error):
////                print(error)
////            }
////        }
//    }
//
//    private func fetchData() {
//
//        // для загрузки рецептов, используя URLSession
//
//        let url = Link.recipesURL(offset: 0, query: "").url
//
//        networkManager.fetch(ComplexSearch.self, from: url) { result in
//            switch result {
//            case .success(let recipes):
//                print(recipes)
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        // для загрузки рецепта, используя URLSession
//
////        let url = Link.recipeDetailsURL(recipeID: 705309).url
////
////        networkManager.fetch(Recipe.self, from: url) { result in
////            switch result {
////            case .success(let recipe):
////                print(recipe)
////            case .failure(let error):
////                print(error)
////            }
////        }
//
//    }


//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

struct MealAPI {
    
    static let baseURL: String = "https://themealdb.com/api/json/v1/1/"
    
    enum Endpoint {
        case getSearchAPI
        var url: URL? {
            switch self {
            case .getSearchAPI:
                return URL(string: "\(baseURL)search.php")
            }
        }
    }
}

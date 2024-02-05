//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

internal final class MealListItemMapper {
    
    private static let OK_200 = 200
    
    internal static func map(_ data: Data, _ response: HTTPURLResponse) throws  -> [MealItemDto] {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard response.statusCode == OK_200,
              let root = try? decoder.decode(Root.self, from: data) else {
                  throw RemoteSearchMealListLoader.Error.invalidData
        }
        return root.meals
    }
}

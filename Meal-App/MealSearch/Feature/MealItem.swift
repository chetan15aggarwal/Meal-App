//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

struct Ingredient: Equatable, Hashable {
    var ingredientName: String
    var measurement: String
    
    init?(_ name: String?, measurement: String?) {
        guard let name, let measurement, !name.isEmpty, !measurement.isEmpty else {
            return nil
        }
        self.ingredientName = name
        self.measurement = measurement
    }
}

struct MealItem: Equatable, Hashable {
    var id: String
    var name: String
    var category: String
    var area: String
    var instructions: String
    var mealThumbUrl: URL?
    var tags: [String]
    var youtubeUrl: URL?
    var sourceUrl: URL?
    var ingredients: [Ingredient]?
}

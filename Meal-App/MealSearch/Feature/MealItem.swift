//
// Meal-App
// Created by Chetan Aggarwal.


import Foundation

struct Ingredient: Equatable {
    var ingredientName: String
    var measurement: String
}

struct MealItem: Equatable {
    var id: Double
    var name: String
    var category: String
    var area: String
    var instructions: String
    var mealThumbUrl: URL?
    var tags: [String]
    var youtubeUrl: URL?
    var sourceUrl: URL?
    var ingredients: [Ingredient]
}

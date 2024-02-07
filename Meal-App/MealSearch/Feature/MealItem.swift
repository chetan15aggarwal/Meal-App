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

struct MealItem: Equatable, Hashable, Identifiable {
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
    
    static func preview() -> [MealItem] {
        return [MealItem(
            id: "52771",
            name: "Spicy Arrabiata Penne",
            category: "Vegetarian",
            area: "Italian",
            instructions: "Bring a large pot of water to a boil.",
            mealThumbUrl: URL(string: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg"), tags: ["Pasta","Curry"],
            youtubeUrl: URL(string: "https://www.youtube.com/watch?v=1IszT_guI08"),
            ingredients: [Ingredient("penne rigate", measurement: "1 pound")!,Ingredient("olive oil", measurement: "1/4 cup")!]
        ), MealItem(
            id: "51771",
            name: "Pizza",
            category: "Vegetarian",
            area: "Italian",
            instructions: "Bring a large pot of water to a boil.",
            mealThumbUrl: URL(string: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg"), tags: ["Pasta","Curry"],
            youtubeUrl: URL(string: "https://www.youtube.com/watch?v=1IszT_guI08"),
            ingredients: [Ingredient("penne rigate", measurement: "1 pound")!,Ingredient("olive oil", measurement: "1/4 cup")!]
        )]
    }
}

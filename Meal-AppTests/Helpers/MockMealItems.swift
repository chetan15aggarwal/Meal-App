//
// Meal-AppTests
// Created by Chetan Aggarwal.

import Foundation
import XCTest
@testable import Meal_App

struct MockMealItems {
    func makeItem(id: String, name: String, category: String, area: String, instructions: String, mealThumbUrl: URL, tags: [String], youtubeUrl: URL, sourceUrl: URL, ingredients: [Ingredient]) -> (model: MealItem, json: [String: Any]) {
        
        let allIngredients = ingredients.map { Ingredient($0.ingredientName, measurement: $0.measurement) }

        let item = MealItem(id: id, name: name, category: category, area: area, instructions: instructions, mealThumbUrl: mealThumbUrl, tags: tags, youtubeUrl: youtubeUrl, sourceUrl: sourceUrl, ingredients: allIngredients.compactMap{$0})
        
        var json: [String: Any] = [
            "idMeal": id,
            "strMeal" : name,
            "strCategory": category,
            "strArea": area,
            "strInstructions": instructions,
            "strMealThumb": mealThumbUrl.absoluteString,
            "strTags": tags.joined(separator: ","),
            "strYoutube": youtubeUrl.absoluteString,
            "strSource": sourceUrl.absoluteString,
        ]
        
        for (index, _) in (0..<20).enumerated() {
            let keyIngredient = "strIngredient\(index + 1)"
            let keyMeasure = "strMeasure\(index + 1)"
            
            json[keyIngredient] = index < ingredients.count ? ingredients[index].ingredientName : ""
            json[keyMeasure] = index < ingredients.count ? ingredients[index].measurement : ""
        }

        return (item, json)
    }
    
    func getItem1() -> (model: MealItem, json: [String: Any]){
        
        let item1 = makeItem(id: "1111", name: "Kumpir", category: "Side", area: "Turkish", instructions: "If you order kumpir in Turkey", mealThumbUrl: URL(string: "https://www.themealdb.com/images/media/meals/mlchx21564916997.jpg")!, tags: ["SideDish"], youtubeUrl: URL(string: "https://www.youtube.com/watch?v=IEDEtZ4UVtI")!, sourceUrl: URL(string: "http://www.turkeysforlife.com/2013/10/firinda-kumpir-turkish-street-food.html")!, ingredients: [Ingredient("Potatoes", measurement: "2 large"), Ingredient("Butter", measurement: "2 tbs")].compactMap{$0})
        
        return item1
    }
    
    func getItem2() -> (model: MealItem, json: [String: Any]){
        let item2 = makeItem(id: "222", name: "Poutine", category: "Miscellaneous", area: "Canadian", instructions: "If you order kumpir in Turkey", mealThumbUrl: URL(string: "https://www.themealdb.com/images/media/meals/mlchx21564916997.jpg")!, tags: ["SideDish"], youtubeUrl: URL(string: "https://www.youtube.com/watch?v=IEDEtZ4UVtI")!, sourceUrl: URL(string: "http://www.turkeysforlife.com/2013/10/firinda-kumpir-turkish-street-food.html")!, ingredients: [Ingredient("Vegetable Oil", measurement: "2 large"), Ingredient("Butter", measurement: "2 tbs")].compactMap{$0})
        
        return item2
    }
}

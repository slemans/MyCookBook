
import UIKit

struct Recipes: Codable {
    let q: String
    let to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
    init?(recipe: Recipes) {
        self.q = recipe.q
        self.to = recipe.to
        self.more = recipe.more
        self.count = recipe.count
        self.hits = recipe.hits
    }

}
struct Hit: Codable {
    let recipe: Recipe
}
struct Recipe: Codable{
    var favorite: Bool?
    let label: String?
    let image: String?
    let totalTime: Int?
    let mealType: [MealType?]
    let totalNutrients: [String: Total?]
    let calories: Double?
    let ingredients: [Ingredient?]
    let healthLabels: [String]?
}
struct Ingredient: Codable {
    let text: String?
    enum CodingKeys: String, CodingKey {
        case text
    }
}
enum MealType: String, Codable {
    case brunch = "brunch"
    case lunchDinner = "lunch/dinner"
    case breakfast = "breakfast"
    case teatime = "teatime"
    case snack = "snack"
}
struct Total: Codable {
    let label: String?
    let quantity: Double?
    let unit: Unit?
}
enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}



//
//struct Recipe: Codable{
//    var favorite: Bool?
//    let label: String
//    let image: String
//    let totalTime: Int
//    let mealType: [MealType?]
//    let totalNutrients: [String: Total]?
//    let calories: Double
//    let ingredients: [Ingredient]?
//    let healthLabels: [String]?
//}
//struct Ingredient: Codable {
//    let text: String
//    enum CodingKeys: String, CodingKey {
//        case text
//    }
//}
//enum MealType: String, Codable {
//    case brunch = "brunch"
//    case lunchDinner = "lunch/dinner"
//    case breakfast = "breakfast"
//    case teatime = "teatime"
//    case snack = "snack"
//}
//struct Total: Codable {
//    let label: String
//    let quantity: Double
//    let unit: Unit
//}
//enum Unit: String, Codable {
//    case empty = "%"
//    case g = "g"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}
















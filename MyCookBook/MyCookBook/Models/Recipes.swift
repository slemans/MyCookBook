
import Foundation

struct Recipes: Codable {
    let q: String
    let to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
    init?(recipe: Recipes){
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
struct Recipe: Codable {
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels, healthLabels: [String]
    let cautions: [Caution]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let cuisineType: [String]
    let mealType: [MealType]
    let dishType: [DishType]
    let totalNutrients, totalDaily: [String: Total]
    let digest: [Digest]
}

enum Caution: String, Codable {
    case fodmap = "FODMAP"
    case sulfites = "Sulfites"
}

struct Ingredient: Codable {
    let text: String
    let weight: Double
    let foodCategory, foodID: String
    // let image: String?

    enum CodingKeys: String, CodingKey {
        case text, weight, foodCategory
        case foodID = "foodId"
        // case image
    }
}

enum MealType: String, Codable {
    case brunch = "brunch"
    case lunchDinner = "lunch/dinner"
}

enum DishType: String, Codable {
    case condimentsAndSauces = "condiments and sauces"
    case mainCourse = "main course"
    case starter = "starter"
}

struct Digest: Codable {
    let label, tag: String
    let schemaOrgTag: SchemaOrgTag?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?
}

struct Total: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}



enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}



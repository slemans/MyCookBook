
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
struct Recipe: Codable {
    var favorite: Bool?
    let label: String?
    let image: String?
    let totalTime: Double?
    let mealType: [MealType?]
    let totalNutrients: [String: Total?]
    let calories: Double?
    let ingredients: [Ingredient?]
    let healthLabels: [String?]

//    init?(favorite: Bool?, label: String?, image: String?, totalTime: Any?, mealType: [MealType?],
//         totalNutrients: [String: Total?], calories: Double?, ingredients: [Ingredient?], healthLabels: [String?]) {
//        self.favorite = favorite
//        self.label = label
//        self.image = image
//        self.mealType = mealType
//        self.totalNutrients = totalNutrients
//        self.calories = calories
//        self.ingredients = ingredients
//        self.healthLabels = healthLabels
//        self.totalTime = nil
//    }
    

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





// fish
//// MARK: - Recipe
//struct Recipe: Codable {
//    let dietLabels: [DietLabel]
//    let totalNutrients: [String: Total]
//    let healthLabels: [HealthLabel]
//    let dishType: [String]?
//    let totalDaily: [String: Total]
//    let digest: [Digest]
//    let ingredients: [Ingredient]
//    let cautions: [Caution]
//    let totalTime: Double
//    let ingredientLines: [String]
//}

//Pork {
//    let totalDaily, totalNutrients: [String: Total]
//    let cautions: [String]
//    let ingredientLines: [String]
//    let dishType: [DishType]
//    let dietLabels: [String]
//    let ingredients: [Ingredient]
//    let digest: [Digest]
//    let totalTime: Int
//    let healthLabels: [HealthLabel]
//}

//beef {
//    let ingredients: [Ingredient]
//    let digest: [Digest]
//    let totalDaily: [String: Total]
//    let ingredientLines: [String]
//    let totalNutrients: [String: Total]
//    let totalTime: Int
//    let dishType: [DishType]
//    let cautions, healthLabels, dietLabels: [String]
//}





//
//enum Caution: String, Codable {
//    case fodmap = "FODMAP"
//    case gluten = "Gluten"
//    case shellfish = "Shellfish"
//    case sulfites = "Sulfites"
//    case treeNuts = "Tree-Nuts"
//    case wheat = "Wheat"
//}
//
//enum DietLabel: String, Codable {
//    case highProtein = "High-Protein"
//    case lowCarb = "Low-Carb"
//    case lowFat = "Low-Fat"
//}
//
//// MARK: - Digest
//struct Digest: Codable {
//    let sub: [Digest]?
//    let unit: Unit
//    let daily: Double
//    let schemaOrgTag: SchemaOrgTag?
//    let total: Double
//    let label: Label
//    let tag: String
//    let hasRDI: Bool
//}
//
//enum Label: String, Codable {
//    case calcium = "Calcium"
//    case carbs = "Carbs"
//    case carbsNet = "Carbs (net)"
//    case cholesterol = "Cholesterol"
//    case energy = "Energy"
//    case fat = "Fat"
//    case fiber = "Fiber"
//    case folateEquivalentTotal = "Folate equivalent (total)"
//    case folateFood = "Folate (food)"
//    case folicAcid = "Folic acid"
//    case iron = "Iron"
//    case magnesium = "Magnesium"
//    case monounsaturated = "Monounsaturated"
//    case niacinB3 = "Niacin (B3)"
//    case phosphorus = "Phosphorus"
//    case polyunsaturated = "Polyunsaturated"
//    case potassium = "Potassium"
//    case protein = "Protein"
//    case riboflavinB2 = "Riboflavin (B2)"
//    case saturated = "Saturated"
//    case sodium = "Sodium"
//    case sugarAlcohols = "Sugar alcohols"
//    case sugars = "Sugars"
//    case sugarsAdded = "Sugars, added"
//    case thiaminB1 = "Thiamin (B1)"
//    case trans = "Trans"
//    case vitaminA = "Vitamin A"
//    case vitaminB12 = "Vitamin B12"
//    case vitaminB6 = "Vitamin B6"
//    case vitaminC = "Vitamin C"
//    case vitaminD = "Vitamin D"
//    case vitaminE = "Vitamin E"
//    case vitaminK = "Vitamin K"
//    case water = "Water"
//    case zinc = "Zinc"
//}
//
//enum SchemaOrgTag: String, Codable {
//    case carbohydrateContent = "carbohydrateContent"
//    case cholesterolContent = "cholesterolContent"
//    case fatContent = "fatContent"
//    case fiberContent = "fiberContent"
//    case proteinContent = "proteinContent"
//    case saturatedFatContent = "saturatedFatContent"
//    case sodiumContent = "sodiumContent"
//    case sugarContent = "sugarContent"
//    case transFatContent = "transFatContent"
//}
//
//enum Unit: String, Codable {
//    case empty = "%"
//    case g = "g"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}
//
//enum HealthLabel: String, Codable {
//    case alcoholFree = "Alcohol-Free"
//    case dash = "DASH"
//    case fodmapFree = "FODMAP-Free"
//    case immunoSupportive = "Immuno-Supportive"
//    case ketoFriendly = "Keto-Friendly"
//    case mediterranean = "Mediterranean"
//    case peanutFree = "Peanut-Free"
//    case pescatarian = "Pescatarian"
//    case sugarConscious = "Sugar-Conscious"
//    case sulfiteFree = "Sulfite-Free"
//    case treeNutFree = "Tree-Nut-Free"
//}
//
//// MARK: - Ingredient
//struct Ingredient: Codable {
//    let weight: Double
//    let image: String?
//    let foodCategory: String?
//    let foodID, text: String
//
//    enum CodingKeys: String, CodingKey {
//        case weight, image, foodCategory
//        case foodID = "foodId"
//        case text
//    }
//}
//
//enum MealType: String, Codable {
//    case lunchDinner = "lunch/dinner"
//    case snack = "snack"
//}
//
//// MARK: - Total
//struct Total: Codable {
//    let quantity: Double
//    let unit: Unit
//    let label: Label
//}
//




//---------------- pork ----------




//// MARK: - Recipe
//struct Recipe: Codable {
//    let cuisineType: [String]
//    let url: String
//    let totalDaily, totalNutrients: [String: Total]
//    let label: String
//    let cautions: [String]
//    let image: String
//    let yield: Int
//    let calories: Double
//    let mealType: [MealType]
//    let ingredientLines: [String]
//    let dishType: [DishType]
//    let dietLabels: [String]
//    let shareAs: String
//    let ingredients: [Ingredient]
//    let source: String
//    let digest: [Digest]
//    let totalWeight: Double
//    let totalTime: Int
//    let uri: String
//    let healthLabels: [HealthLabel]
//}
//
//// MARK: - Digest
//struct Digest: Codable {
//    let tag: String
//    let hasRDI: Bool
//    let sub: [Digest]?
//    let daily: Double
//    let unit: Unit
//    let label: String
//    let schemaOrgTag: SchemaOrgTag?
//    let total: Double
//}
//
//enum SchemaOrgTag: String, Codable {
//    case carbohydrateContent = "carbohydrateContent"
//    case cholesterolContent = "cholesterolContent"
//    case fatContent = "fatContent"
//    case fiberContent = "fiberContent"
//    case proteinContent = "proteinContent"
//    case saturatedFatContent = "saturatedFatContent"
//    case sodiumContent = "sodiumContent"
//    case sugarContent = "sugarContent"
//    case transFatContent = "transFatContent"
//}
//
//enum Unit: String, Codable {
//    case empty = "%"
//    case g = "g"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}
//
//enum DishType: String, Codable {
//    case mainCourse = "main course"
//    case mainDish = "main dish"
//}
//
//enum HealthLabel: String, Codable {
//    case alcoholFree = "Alcohol-Free"
//    case ketoFriendly = "Keto-Friendly"
//    case peanutFree = "Peanut-Free"
//    case sugarConscious = "Sugar-Conscious"
//    case sulfiteFree = "Sulfite-Free"
//    case treeNutFree = "Tree-Nut-Free"
//}
//
//// MARK: - Ingredient
//struct Ingredient: Codable {
//    let foodID, foodCategory: String
//    let image: String
//    let weight: Double
//    let text: String
//
//    enum CodingKeys: String, CodingKey {
//        case foodID = "foodId"
//        case foodCategory, image, weight, text
//    }
//}
//
//enum MealType: String, Codable {
//    case brunch = "brunch"
//    case lunchDinner = "lunch/dinner"
//}
//
//// MARK: - Total
//struct Total: Codable {
//    let unit: Unit
//    let label: String
//    let quantity: Double
//}
//


// --------------- beef ---------


//// MARK: - Recipe
//struct Recipe: Codable {
//    let ingredients: [Ingredient]
//    let digest: [Digest]
//    let source: String
//    let url: String
//    let label: String
//    let totalDaily: [String: Total]
//    let calories: Double
//    let cuisineType: [String]
//    let mealType: [MealType]
//    let ingredientLines: [String]
//    let totalNutrients: [String: Total]
//    let shareAs: String
//    let totalTime: Int
//    let dishType: [DishType]
//    let totalWeight: Double
//    let yield: Int
//    let uri: String
//    let cautions, healthLabels, dietLabels: [String]
//    let image: String
//}
//
//// MARK: - Digest
//struct Digest: Codable {
//    let tag: String
//    let hasRDI: Bool
//    let schemaOrgTag: SchemaOrgTag?
//    let label: String
//    let daily: Double
//    let unit: Unit
//    let total: Double
//    let sub: [Digest]?
//}
//
//enum SchemaOrgTag: String, Codable {
//    case carbohydrateContent = "carbohydrateContent"
//    case cholesterolContent = "cholesterolContent"
//    case fatContent = "fatContent"
//    case fiberContent = "fiberContent"
//    case proteinContent = "proteinContent"
//    case saturatedFatContent = "saturatedFatContent"
//    case sodiumContent = "sodiumContent"
//    case sugarContent = "sugarContent"
//    case transFatContent = "transFatContent"
//}
//
//enum Unit: String, Codable {
//    case empty = "%"
//    case g = "g"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}
//
//enum DishType: String, Codable {
//    case condimentsAndSauces = "condiments and sauces"
//    case mainCourse = "main course"
//    case sandwiches = "sandwiches"
//}
//
//// MARK: - Ingredient
//struct Ingredient: Codable {
//    let text: String
//    let weight: Double
//    let foodCategory, foodID: String
//    let image: String?
//
//    enum CodingKeys: String, CodingKey {
//        case text, weight, foodCategory
//        case foodID = "foodId"
//        case image
//    }
//}
//
//enum MealType: String, Codable {
//    case lunchDinner = "lunch/dinner"
//}
//
//// MARK: - Total
//struct Total: Codable {
//    let unit: Unit
//    let label: String
//    let quantity: Double
//}
//

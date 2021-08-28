//
//  Recipes.swift
//  MyCookBook
//
//  Created by sleman on 25.08.21.
//

import Foundation

struct Recipe: Decodable{
    let ingredientLines: [String?]
    let image: String?
    let totalTime: Int?
    let ingredients: [Ingredients?]
    let dietLabels: [String?]
    let digest: [Digest?]
    let totalNutrients: [TotalNutrients?]
    let totalWeight: Double?
    let url: String?
    let healthLabels: [String?]
    let mealType: [String?]
    let dishType: [String?]
    let uri: String?
    let yield: Int?
    let cuisineType: [String?]
    let totalDaily: TotalDaily?
    let shareAs: String?
    let source: String?
    let cautions: [String?]
    let calories: Double?
    let label: String?
    
}

struct Ingredients: Decodable{
    let text: String?
    let weight: Int?
    let foodCategory: String?
    let foodId: String?
    let image: String?
}
struct Digest: Decodable{
    let hasRDI: Bool?
    let total: Double?
    let sub: [Sub?]
    let schemaOrgTag: String?
    let label: String?
    let daily: Double?
    let tag: String?
    let unit: String?
}
struct Sub: Decodable{
    let label: String?
    let daily: Double?
    let tag: String?
    let total: Double?
    let schemaOrgtag: String?
    let unit: String?
    let hasRDI: Bool?
}
struct TotalNutrients: Decodable{
    let fat: Fat?
    let ribf: Ribf?
    let vitb6a: Vitb6a?
    let vit_rae: Vit_rae?
    let procnt: Procnt?
    let vitd: Vitd?
    let f0ldfe: F0ldfe?
    let fasat: Fasat?
    let vitk1: Vitk1?
    let fams: Fams?
    let fibtg: Fibtg?
    let k: K?
    let water: Water?
    let fapu: Fapu?
    let f0lfd: F0lfd?
    let na: Na?
    let chole: Chole?
    let fe: Fe?
    let zn: Zn?
    let mg: Mg?
    let vitb12: Vitb12?
    let p: P?
    let ch0cdf: Ch0cdf?
    let ca: Ca?
    let nia: Nia?
    let enerc_kcal: Enerc_kcal?
    let f0lac: F0lac?
    let sugar: Sugar?
    let vitc: Vitc?
    let fatrn: Fatrn?
    let thia: Thia?
    let t0cpha: T0cpha?
}
struct TotalDaily: Decodable{
    let fat: Fat?
    let ribf: Ribf?
    let vitb6a: Vitb6a?
    let vit_rae: Vit_rae?
    let procnt: Procnt?
    let vitd: Vitd?
    let f0ldfe: F0ldfe?
    let fasat: Fasat?
    let vitk1: Vitk1?
    let fibtg: Fibtg?
    let k: K?
    let na: Na?
    let chole: Chole?
    let mg: Mg?
    let fe: Fe?
    let zn: Zn?
    let vitb12: Vitb12?
    let p: P?
    let ch0cdf: Ch0cdf?
    let ca: Ca?
    let nia: Nia?
    let enerc_kcal: Enerc_kcal?
    let vitc: Vitc?
    let thia: Thia?
    let t0cpha: T0cpha?
}


struct T0cpha: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Fat: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Ribf: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Vitb6a: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Vit_rae: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Procnt: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Vitd: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct F0ldfe: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Fasat: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Vitk1: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Fams: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Fibtg: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Na: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct F0lfd: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Fapu: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Water: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct K: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Chole: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Fe: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Zn: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Mg: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Vitb12: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct P: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Ch0cdf: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Ca: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Nia: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Enerc_kcal: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct F0lac: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Sugar: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Vitc: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Fatrn: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}
struct Thia: Decodable{
    let quantily: Double?
    let unit: String?
    let label: String?
}

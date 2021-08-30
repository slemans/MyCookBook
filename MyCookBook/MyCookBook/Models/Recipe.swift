//
//  Recipes.swift
//  MyCookBook
//
//  Created by sleman on 25.08.21.
//

import Foundation

struct Tasks: Codable{
    let to: Int?
    let q: String?
    let more: Bool?
    let from: Int?
   // let hits: [Recipe]
    let count: Int?
    
    
}
struct Recipe: Codable {
    let shareAs: String?
    let cautions: [String?]
    let image: String?
    let totalNutrients: [TotalNutrients?]
    let totalDaily: [TotalDaily?]
    let totalWeight: Double?
    let dietLabels: [String?]
    let calories: Double?
    let mealType: [String?]
    let ingredients: [Ingredients?]
    let source: String?
    let ingredientLines: [String?]
    let url: String?
    let healthLabels: [String?]
    let cuisineType: [String?]
    let dishType: [String?]
    let yield: Int?
    let uri: String?
    let label: String?
    let digest: [Digest?]
    let totalTime: Int?
}


struct Ingredients: Codable{
    let image: String?
    let text: String?
    let foodCategory: String?
    let foodId: String?
    let weight: Int?
}
struct Digest: Codable{
    let hasRDI: Bool?
    let daily: Double?
    let label: String?
    let schemaOrgTag: String?
    let sub: [Sub?]
    let unit: String?
    let tag: String?
    let total: Double?
}
struct Sub: Codable{
    let daily: Double?
    let tag: String?
    let unit: String?
    let label: String?
    let total: Double?
    let hasRDI: Bool?
    let schemaOrgtag: String?
}
struct TotalDaily: Codable{
    let mg: Mg?
    let procnt: Procnt?
    let na: Na?
    let fasat: Fasat?
    let t0cpha: T0cpha?
    let fibtg: Fibtg?
    let p: P?
    let vitd: Vitd?
    let vitb12: Vitb12?
    let chole: Chole?
    let vitk1: Vitk1?
    let ca: Ca?
    let vit_rae: Vit_rae?
    let fe: Fe?
    let vitc: Vitc?
    let k: K?
    let fat: Fat?
    let vitb6a: Vitb6a?
    let enerc_kcal: Enerc_kcal?
    let f0ldfe: F0ldfe?
    let ch0cdf: Ch0cdf?
    let thia: Thia?
    let ribf: Ribf?
    let nia: Nia?
}
struct TotalNutrients: Codable{
    let t0cpha: T0cpha?
    let vitb12: Vitb12?
    let mg: Mg?
    let sugar: Sugar?
    let p: P?
    let vitk1: Vitk1?
    let fat: Fat?
    let f0lfd: F0lfd?
    let fibtg: Fibtg?
    let ribf: Ribf?
    let vita_rae: Vit_rae?
    let zn: Zn?
    let fatrn: Fatrn?
    let vitb6a: Vitb6a?
    let thia: Thia?
    let fams: Fams?
    let fasat: Fasat?
    let enerc_kcal: Enerc_kcal?
    let water: Water?
    let f0lac: F0lac?
    let na: Na?
    let vitd: Vitd?
    let nia: Nia?
    let chole: Chole?
    let fapu: Fapu?
    let k: K?
    let ch0cdf: Ch0cdf?
    let f0ldfe: F0ldfe?
    let procnt: Procnt?
    let ca: Ca?
    let vitc: Vitc?
    let fe: Fe?
}


struct T0cpha: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Fat: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Ribf: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Vitb6a: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Vit_rae: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Procnt: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Vitd: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct F0ldfe: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Fasat: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Vitk1: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Fams: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Fibtg: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Na: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct F0lfd: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Fapu: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Water: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct K: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Chole: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Fe: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Zn: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Mg: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Vitb12: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct P: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Ch0cdf: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Ca: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Nia: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Enerc_kcal: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct F0lac: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Sugar: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Vitc: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Fatrn: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}
struct Thia: Codable{
    let label: String?
    let unit: String?
    let quantily: Double?
}

//
//  Function.swift
//  MyCookBook
//
//  Created by sleman on 19.09.21.
//

import Foundation

struct tableviewFunction {
   static func returnToFullString(tip: String, recipe: Recipe) -> String {
        guard let quantity = recipe.totalNutrients[tip]?.quantity,
              let unit = recipe.totalNutrients[tip]?.unit.rawValue else { return ""}
        let newQuantity = (Int(quantity) * 10) / 10
        return "\(newQuantity) \(unit)"
    }
}

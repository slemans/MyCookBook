//
//  MainTableViewCell.swift
//  MyCookBook
//
//  Created by sleman on 5.09.21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var imagesRecipe: UIImageView!
    @IBOutlet weak var nameRecipeLb: UILabel!
    @IBOutlet weak var dishTypeLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var sugarLb: UILabel!
    @IBOutlet weak var fatLb: UILabel!
    @IBOutlet weak var carbLb: UILabel!
    @IBOutlet weak var fiberLb: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        imagesRecipe.image = #imageLiteral(resourceName: "icons8-frying-64")
        // imagesRecipe.layer.cornerRadius = 5.0
    }
   


    func fenchRecipe(forrecipe recipe: Recipe?) {
        guard let recipe = recipe else { return }
        nameRecipeLb.text = recipe.label
        dishTypeLb.text = recipe.mealType.first?.rawValue
        timeLb.text = returnTime(time: recipe.totalTime)
        fatLb.text = returnToFullString(tip: "FAT", recipe: recipe)
        fiberLb.text = returnToFullString(tip: "FIBTG", recipe: recipe)
        carbLb.text = returnToFullString(tip: "CHOCDF", recipe: recipe)
        sugarLb.text = String((Int(recipe.calories) * 10) / 10) //returnToFullString(tip: "SUGAR", recipe: recipe)
        putImage(image: recipe.image)
    }
    private func returnTime(time: Int) -> String{
        if time == 0{
            return "time not unknown"
        } else {
            return "\(time) minutes"
        }
        
    }
    
    private func returnToFullString(tip: String, recipe: Recipe) -> String {
        guard let quantity = recipe.totalNutrients[tip]?.quantity,
              let unit = recipe.totalNutrients[tip]?.unit.rawValue else { return ""}
        let newQuantity = (Int(quantity) * 10) / 10
        return "\(newQuantity) \(unit)"
    }

    private func putImage(image: String) {
        guard let urlImg = URL(string: image) else { return }
        URLSession.shared.dataTask(with: urlImg) { data, _, _ in
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imagesRecipe.image = image
                    }
                }
            }
        }.resume()
    }

}

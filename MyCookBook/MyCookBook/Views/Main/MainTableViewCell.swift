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
    @IBOutlet weak var calLb: UILabel!
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
        dishTypeLb.text = recipe.dishType.first?.rawValue
        timeLb.text = String(recipe.totalTime)
        fatLb.text = String(recipe.totalNutrients["FAT"]!.quantity)
        fiberLb.text = recipe.totalNutrients["FIBTG"]?.unit.rawValue
        carbLb.text = recipe.totalNutrients["CHOCDF"]?.unit.rawValue
        calLb.text = recipe.totalNutrients["CA"]?.unit.rawValue
        putImage(image: recipe.image)

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

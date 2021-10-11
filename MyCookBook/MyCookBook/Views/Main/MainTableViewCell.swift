//
//  MainTableViewCell.swift
//  MyCookBook
//
//  Created by sleman on 5.09.21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var indicatorActiviti: UIActivityIndicatorView!
    @IBOutlet weak var imagesRecipe: UIImageView!
    @IBOutlet weak var nameRecipeLb: UILabel!
    @IBOutlet weak var dishTypeLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var sugarLb: UILabel!
    @IBOutlet weak var fatLb: UILabel!
    @IBOutlet weak var carbLb: UILabel!
    @IBOutlet weak var fiberLb: UILabel!
    @IBOutlet weak var secondStackViewCell: UIStackView!
    @IBOutlet weak var firstStackViewCell: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imagesRecipe.image = #imageLiteral(resourceName: "imagePlaceholder")
        firstStackViewCell.layer.cornerRadius = NumberCGFloat.numberTen
    }
    func fenchRecipe(forrecipe recipe: Recipe?) {
        guard let recipe = recipe else { return }
        nameRecipeLb.text = recipe.label
        dishTypeLb.text = recipe.mealType.first??.rawValue
        timeLb.text = tableviewFunction.returnTotalTimeString(time: recipe.totalTime)
        fatLb.text = tableviewFunction.returnToFullString(tip: "FAT", recipe: recipe)
        fiberLb.text = tableviewFunction.returnToFullString(tip: "FIBTG", recipe: recipe)
        carbLb.text = tableviewFunction.returnToFullString(tip: "CHOCDF", recipe: recipe)
        sugarLb.text = String((Int(recipe.calories ?? NumberOther.numberZeroDouble) * NumberOther.numberTenForTo) / NumberOther.numberTenForTo)
        putImage(image: recipe.image)
    }
    private func putImage(image: String?) {
        guard let image = image,
            let urlImg = URL(string: image) else { return }
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

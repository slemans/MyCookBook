//
//  MyRecipeTableViewCell.swift
//  MyCookBook
//
//  Created by sleman on 20.09.21.
//

import UIKit

class MyRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameRecipeLb: UILabel!
    @IBOutlet weak var imagesRecipe: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagesRecipe.layer.cornerRadius =  imagesRecipe.frame.size.height / 2
    }
}

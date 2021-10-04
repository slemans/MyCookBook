//
//  FavoriteCell.swift
//  MyCookBook
//
//  Created by sleman on 27.08.21.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var stackImageType: UIStackView!
    @IBOutlet weak var imageType: UIImageView!
    
    
  
    func configure(recipe: Favorite) {
        stackImageType.layer.cornerRadius = stackImageType.frame.size.height / 2
        stackImageType.layer.borderWidth = Border.borderWidth
        stackImageType.layer.borderColor = Color.backgroundColor
        imageType.image = numberCatygoryFood(catygory: recipe.categoryFood)
        nameLb.text = recipe.label
        if recipe.image != nil {
            putImage(image: recipe.image!)
        }
        
    }
    public func numberCatygoryFood(catygory: Int16) -> UIImage{
        var image: UIImage
        switch catygory {
        case 1:
            image = #imageLiteral(resourceName: "icons8-thanksgiving-100")
        case 2:
            image = #imageLiteral(resourceName: "icons8-meat-100")
        case 3:
            image = #imageLiteral(resourceName: "icons8-clown-fish-100")
        default:
            image = #imageLiteral(resourceName: "icons8-pig-80")
        }
        return image
    }
    
    public func putImage(image: String) {
        guard let urlImg = URL(string: image) else { return }
        URLSession.shared.dataTask(with: urlImg) { data, _, _ in
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.images.image = image
                    }
                }
            }
        }.resume()
    }
}

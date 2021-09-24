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
    
    func configure(recipe: Favorite) {
        nameLb.text = recipe.label
        if recipe.image != nil {
            putImage(image: recipe.image!)
        }
        
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

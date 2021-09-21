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
    
    func configure(user: String) {
        nameLb.text = user
        images.image = #imageLiteral(resourceName: "icons8-salt-bae-100")
    }
}

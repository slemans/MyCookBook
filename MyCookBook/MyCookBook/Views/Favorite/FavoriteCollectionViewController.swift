//
//  FavoriteCollectionViewController.swift
//  MyCookBook
//
//  Created by sleman on 2.09.21.
//

import UIKit
import SwiftyJSON

private let reuseIdentifier = "Cell"

class FavoriteCollectionViewController: UICollectionViewController {
    
    var colectionFavorite: [Favorite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    


    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colectionFavorite.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        let favoriteRecipe = colectionFavorite[indexPath.row]
        cell.configure(recipe: favoriteRecipe)
    
        return cell
    }

}

extension FavoriteCollectionViewController: DelegatReturnCollection{
    func returnCollectionView(recipe: Favorite) {
        colectionFavorite.append(recipe)
        collectionView.reloadData()
    }
}

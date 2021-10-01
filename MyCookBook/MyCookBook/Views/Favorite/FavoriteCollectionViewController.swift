//
//  FavoriteCollectionViewController.swift
//  MyCookBook
//
//  Created by sleman on 2.09.21.
//

import UIKit
import SwiftyJSON
import CoreData


private let reuseIdentifier = "Cell"

class FavoriteCollectionViewController: UICollectionViewController {

    var colectionFavorite: [Favorite] = []
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
//    override func viewWillAppear(_ animated: Bool) {
//        loadItems()
//        collectionView.reloadData()
//    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DescriptionVC = segue.destination as? DescriptionViewController {
            DescriptionVC.recipel = sender as? Recipe
            DescriptionVC.mainRecipeOrFavorite = false
        }
    }

    private func loadItems() {
        if let recipes = SettingCoreDate.getFavorite() {
            colectionFavorite = recipes
            collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDataSource
extension FavoriteCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colectionFavorite.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        let favoriteRecipe = colectionFavorite[indexPath.row]
        cell.configure(recipe: favoriteRecipe)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeData = colectionFavorite[indexPath.row].allfavoriteRecipe
        guard let newEncodedDataRecipe = recipeData else { return }
        recipe = parseData(withData: newEncodedDataRecipe)
        performSegue(withIdentifier: "segueFavoriteRecipe", sender: recipe)
    }

    public func parseData(withData data: Data) -> Recipe? {
        let decoder = JSONDecoder()
        do {
            let recipe = try decoder.decode(Recipe.self, from: data)
            return recipe
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}


extension FavoriteCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.size.width / 2.2
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        loadItems()
        collectionView.reloadData()
    }
}

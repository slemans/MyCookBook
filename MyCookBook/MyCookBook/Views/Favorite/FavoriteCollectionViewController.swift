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

    var height: CGFloat!
    var colectionFavorite: [Favorite] = []
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
        collectionView.reloadData()
    }
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
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.borderWidth = Border.borderWidth
        cell.layer.cornerRadius = Border.borderRadius8
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 2
        let padding = 10 * (itemPerRow + 1) // считаю сколько отступов нужно
        let availableWidth = collectionView.frame.width - padding
        let widthPerItem = availableWidth / itemPerRow
        return CGSize(width: widthPerItem, height: 210)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}


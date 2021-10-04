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
    @IBOutlet weak var stackImageType: UIStackView!




    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        self.navigationItem.leftBarButtonItem = self.editButtonItem

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
    override func viewWillAppear(_ animated: Bool) {
//
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.size.width / 2.2
        layout.itemSize = CGSize(width: sizeWH, height: 210)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)

        collectionView.collectionViewLayout = layout

        loadItems()
        collectionView.reloadData()
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
//            let referenceHeight: CGFloat = 300 // Approximate height of your cell
//            let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
//                - sectionInset.left
//                - sectionInset.right
//                - collectionView.contentInset.left
//                - collectionView.contentInset.right
//            return CGSize(width: referenceWidth, height: referenceHeight)
//        }




//    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        var height: CGFloat = 0
//        if let label = colectionFavorite[indexPath.item].label {
//            height = estimateFrameForText(text: label).height //+ padding
//            sizeLable.append(height)
//        }
//        return CGSize(width: 100, height: height)
//    }


}


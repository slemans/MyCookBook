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
//            if let indexPath =  tableView.indexPathForSelectedRow {
//                DescriptionVC.recipel = recipes[indexPath.row].recipe
//            }
//            DescriptionVC.recipeFavorite = sender as? Favorite
            DescriptionVC.recipel = sender as? Recipe
            DescriptionVC.recipeOrFavoriteRecipe = true
        }
    }
    
    private func afff(){
       
    }

    private func loadItems() {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentUser.uid MATCHES %@", FirebaseServise.searchUserFirebase())
        request.predicate = categoryPredicate
        do {
            colectionFavorite = try SettingCoreDate.context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        collectionView.reloadData()
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
        
//        if let jsonData = jsonString.data(using: .utf8){
//            let photoObject = try? JSONDecoder().decode(Recipes.self, from: jsonData)
//        }
        
        
        guard let recipe = colectionFavorite[indexPath.row].allfavoriteRecipe else { return }
        print(recipe)
        let favoriteRecipe = parseJSON(withData: recipe)
//        let favoriteRecipe = try decoder.decode(Recipes.self, from: recipe)
//        let favoriteRecipe = try? JSONDecoder().decode(Recipes.self, from: recipe)
        print("после кодировки \(favoriteRecipe)")
        performSegue(withIdentifier: "segueFavoriteRecipe", sender: favoriteRecipe)
    }
    func parseJSON(withData data: Data) -> Recipes? {
        let decoder = JSONDecoder()
        do {
            let recipes = try decoder.decode(Recipes.self, from: data)
            guard let recipe = Recipes(recipe: recipes) else { return nil }
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

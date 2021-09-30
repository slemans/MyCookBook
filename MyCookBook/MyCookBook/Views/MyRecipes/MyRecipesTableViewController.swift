//
//  MyRecipesTableViewController.swift
//  MyCookBook
//
//  Created by sleman on 3.09.21.
//

import UIKit
import CoreData
import Firebase

class MyRecipesTableViewController: UITableViewController {

    var MyRecipes: [MyRecipe] = []
    var users: [User] = []
    var recipeId: Int? = nil
    let context = SettingCoreDate.getContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()

        let request: NSFetchRequest<User> = User.fetchRequest()
        let searchPredicate = NSPredicate(format: "uid CONTAINS[cd] %@", FirebaseServise.searchUserFirebase())
        request.sortDescriptors = [NSSortDescriptor(key: "uid", ascending: true)]
        request.predicate = searchPredicate
        do {
            users = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        SettingCoreDate.saveInCoreData()
    }
    @IBAction func addNewRecipe(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.Segues.addNewRecipe, sender: nil)
    }
    private func loadItems() {
        let request: NSFetchRequest<MyRecipe> = MyRecipe.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentUser.uid MATCHES %@", FirebaseServise.searchUserFirebase())
        request.predicate = categoryPredicate
        do {
            MyRecipes = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let AddNewRecipeVC = segue.destination as? AddNewRecipeTableViewController {
            AddNewRecipeVC.selectedUser = users[.zero]
            AddNewRecipeVC.recipe = sender as? MyRecipe
            AddNewRecipeVC.delegate = self
            AddNewRecipeVC.recipeId = recipeId
        }
    }
}

// MARK: - Table view data source
extension MyRecipesTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyRecipes.isEmpty ? 0 : MyRecipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMyRecipe", for: indexPath) as! MyRecipeTableViewCell
        let recipe = MyRecipes[indexPath.row]
        cell.nameRecipeLb.text = recipe.name
        cell.imagesRecipe.image = UIImage(data: recipe.images!)
        return cell
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cateroryDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            if let name = self.MyRecipes[indexPath.row].name,
               let userUid = self.users[.zero].uid{
                print(userUid)
                print(name)
                let request: NSFetchRequest<MyRecipe> = MyRecipe.fetchRequest()
                let categoryPredicate = NSPredicate(format: "parentUser.uid MATCHES %@", userUid)
                let itemPredicate = NSPredicate(format: "name MATCHES %@", name)
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, itemPredicate])
                if let recipes = try? self.context.fetch(request) {
                    for recipe in recipes {
                        SettingCoreDate.context.delete(recipe)
                    }
                    self.MyRecipes.remove(at: indexPath.row)
                    SettingCoreDate.saveInCoreData()
                    tableView.reloadData()
                }
            }
        }
        cateroryDelete.image = #imageLiteral(resourceName: "cartm")
        let swipeActions = UISwipeActionsConfiguration(actions: [cateroryDelete])
        return swipeActions
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = MyRecipes[indexPath.row]
        recipeId = indexPath.row
        performSegue(withIdentifier: Constants.Segues.addNewRecipe, sender: recipe)
    }
}

extension MyRecipesTableViewController: DelegatReturnTable {
    func returnTableReviewOld(recipe: MyRecipe, index: Int) {
        MyRecipes[index] = recipe
        tableView.reloadData()
    }
    func returnTableReview(recipe: MyRecipe) {
        MyRecipes.append(recipe)
        tableView.reloadData()
    }
}

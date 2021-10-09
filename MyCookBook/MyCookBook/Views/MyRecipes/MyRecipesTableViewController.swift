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
    var user: User!
    var recipeId: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        user = SettingCoreDate.userCoreDate()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    @IBAction func addNewRecipe(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.Segues.addNewRecipe, sender: nil)
    }
    private func loadItems() {
        if let recipes = SettingCoreDate.getMyRecipes() {
            MyRecipes = recipes
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let AddNewRecipeVC = segue.destination as? AddNewRecipeTableViewController {
            AddNewRecipeVC.selectedUser = user //users[.zero]
            AddNewRecipeVC.recipe = sender as? MyRecipe
            AddNewRecipeVC.delegate = self
            AddNewRecipeVC.recipeId = recipeId
        }
    }
}

// MARK: - Table view data source
extension MyRecipesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyRecipes.isEmpty ? 0 : MyRecipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMyRecipe", for: indexPath) as! MyRecipeTableViewCell
        let recipe = MyRecipes[indexPath.row]
        cell.nameRecipeLb.text = recipe.name
        if let image = UIImage(data: recipe.images!) {
            cell.imagesRecipe.image = image
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let cateroryDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            if let name = self.MyRecipes[indexPath.row].name,
                let userUid = self.user.uid {
                let request: NSFetchRequest<MyRecipe> = MyRecipe.fetchRequest()
                let categoryPredicate = NSPredicate(format: "parentUser.uid MATCHES %@", userUid)
                let itemPredicate = NSPredicate(format: "name MATCHES %@", name)
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, itemPredicate])
                if let recipes = try? SettingCoreDate.context.fetch(request) {
                    for recipe in recipes {
                        SettingCoreDate.context.delete(recipe)
                    }
                    self.MyRecipes.remove(at: indexPath.row)
                    SettingCoreDate.saveInCoreData()
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
        cateroryDelete.image = #imageLiteral(resourceName: "cartm")
        let swipeActions = UISwipeActionsConfiguration(actions: [cateroryDelete])
        return swipeActions
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //cell can move to another location in the table view or no
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let firstRecipe = MyRecipes.remove(at: sourceIndexPath.row)
        MyRecipes.insert(firstRecipe, at: destinationIndexPath.row)
        tableView.reloadData()
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

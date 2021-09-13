//
//  MyRecipesTableViewController.swift
//  MyCookBook
//
//  Created by sleman on 3.09.21.
//

import UIKit

class MyRecipesTableViewController: UITableViewController {

    private var myRecipe: Recipes!
    private var masRecipes: [Hit] = []
    var serviseAPI = ServiseAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        //getTwoUrlSession()
    }
//    func getTwoUrlSession() {
//        serviseAPI.fetchUrlSession(forType: .chicken){ recipe in
//            if recipe.hits.count != 0{
//                self.masRecipes = recipe.hits
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masRecipes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let recipe = masRecipes[indexPath.row]
        cell.textLabel?.text = recipe.recipe.label
        //cell.textLabel?.text = "\(indexPath)"
//        cell.detailTextLabel?.text = String(recipe.recipe.calories)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .red

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  DemoViewController.swift
//  MyCookBook
//
//  Created by sleman on 29.08.21.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var categoryThree: UIButton!
    @IBOutlet weak var categoryOne: UIButton!
    @IBOutlet weak var categoryTwo: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    var serviseAPI = ServiseAPI()
    private var recipes: [Hit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getTwoUrlSession(type: .pork)

    }
    @IBAction func beefActionBt() {
        getTwoUrlSession(type: .pork)
    }
    @IBAction func chiekenActionBt() {
        getTwoUrlSession(type: .chicken)
    }
    @IBAction func sneckActionBt() {
        getTwoUrlSession(type: .beef)
    }
    @IBAction func feshActionBt() {
        getTwoUrlSession(type: .fish)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DescriptionVC = segue.destination as? DescriptionViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                DescriptionVC.recipel = recipes[indexPath.row].recipe
            }
        }
    }

    

    func getTwoUrlSession(type food: TypeFood) {
        serviseAPI.fetchUrlSession(forType: food) { recipes in
                self.recipes = recipes.hits
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.indicatorActivity.stopAnimating()
                }
        }
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let recipe = recipes[indexPath.row].recipe
        cell.fenchRecipe(forrecipe: recipe)
        return cell
    }
    
}



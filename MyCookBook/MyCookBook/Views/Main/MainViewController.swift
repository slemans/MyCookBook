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
    
    var serviseAPI = ServiseAPI()
    private var recipes: [Hit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTwoUrlSession()
    }
    


    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        
    }
    
    func getTwoUrlSession() {
        serviseAPI.fetchUrlSession(forType: .chicken){ recipes in
            if recipes.hits.count != 0{
                self.recipes = recipes.hits
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let recipe = recipes[indexPath.row].recipe
        cell.fenchRecipe(forrecipe: recipe)
        return cell
    }
}



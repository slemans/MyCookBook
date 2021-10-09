//
//  DemoViewController.swift
//  MyCookBook
//
//  Created by sleman on 29.08.21.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
//
//    @IBOutlet weak var stackMain: UIStackView!
//
    @IBOutlet weak var categoryFirstBt: UIButton!
    @IBOutlet weak var categorySecondBt: UIButton!
    @IBOutlet weak var categoryThreeBt: UIButton!
    @IBOutlet weak var categoryForeBt: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    var serviseAPI = ServiseAPI()
    var pageTo = numberOther.numberTenForTo
    private var recipes: [Hit] = []
    var categoryFood: TypeFood = .pork
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
    }
    
    public func startSetting() {
        getUrlSession(type: .pork, numberTo: pageTo)
        categoryFirstBt.layer.cornerRadius = categoryFirstBt.frame.size.height / 2
        categorySecondBt.layer.cornerRadius = categorySecondBt.frame.size.height / 2
        categoryThreeBt.layer.cornerRadius = categoryThreeBt.frame.size.height / 2
        categoryForeBt.layer.cornerRadius = categoryForeBt.frame.size.height / 2
    }
    
    @IBAction func beefActionBt() {
        categoryFood = .pork
        pageToZero()
        getUrlSession(type: categoryFood, numberTo: numberOther.numberTenForTo)
    }
    @IBAction func chiekenActionBt() {
        categoryFood = .chicken
        pageToZero()
        getUrlSession(type: categoryFood, numberTo: numberOther.numberTenForTo)
    }
    @IBAction func sneckActionBt() {
        categoryFood = .beef
        pageToZero()
        getUrlSession(type: categoryFood, numberTo: numberOther.numberTenForTo)
    }
    @IBAction func fishActionBt() {
        categoryFood = .fish
        pageToZero()
        getUrlSession(type: categoryFood, numberTo: numberOther.numberTenForTo)
    }
    public func pageToZero(){
        pageTo = 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DescriptionVC = segue.destination as? DescriptionViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                DescriptionVC.recipel = recipes[indexPath.row].recipe
                DescriptionVC.categoryFood = categoryFood
                DescriptionVC.mainRecipeOrFavorite = true
            }
        }
    }
    func getUrlSession(type food: TypeFood, numberTo: Int) {
        serviseAPI.fetchUrlSession(forType: food, numberTo: numberTo) { recipes in
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row == recipes.count - 1 { // last cell
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(144))
            self.tableView.tableFooterView = spinner
            pageTo += numberOther.numberTenForTo
            getUrlSession(type: categoryFood, numberTo: pageTo)
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let recipe = recipes[indexPath.row].recipe
        cell.fenchRecipe(forrecipe: recipe)
        return cell
    }
    
}



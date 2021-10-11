//
//  DemoViewController.swift
//  MyCookBook
//
//  Created by sleman on 29.08.21.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var categoryFirstBt: UIButton!
    @IBOutlet weak var categorySecondBt: UIButton!
    @IBOutlet weak var categoryThreeBt: UIButton!
    @IBOutlet weak var categoryForeBt: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    var serviseAPI = ServiseAPI()
    var pageTo = NumberOther.numberTenForTo
    private var recipes: [Hit] = []
    var categoryFood: TypeFood = .pork
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
    }
    @IBAction func beefActionBt() {
        categoryFood = .pork
        borderBtVanishOrNo(typeFood: categoryFood)
        getUrlSession(type: categoryFood, numberTo: NumberOther.numberTenForTo)
    }
    @IBAction func chiekenActionBt() {
        categoryFood = .chicken
        borderBtVanishOrNo(typeFood: categoryFood)
        getUrlSession(type: categoryFood, numberTo: NumberOther.numberTenForTo)
    }
    @IBAction func sneckActionBt() {
        categoryFood = .beef
        borderBtVanishOrNo(typeFood: categoryFood)
        getUrlSession(type: categoryFood, numberTo: NumberOther.numberTenForTo)
    }
    @IBAction func fishActionBt() {
        categoryFood = .fish
        borderBtVanishOrNo(typeFood: categoryFood)
        getUrlSession(type: categoryFood, numberTo: NumberOther.numberTenForTo)
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
    private func getUrlSession(type food: TypeFood, numberTo: Int) {
        serviseAPI.fetchUrlSession(forType: food, numberTo: numberTo) { recipes in
                self.recipes = recipes.hits
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.indicatorActivity.stopAnimating()
                }
        }
    }
    public func pageToZero(){
        pageTo = NumberOther.numberZeroInt
        recipes.removeAll()
        tableView.reloadData()
    }
    public func startSetting() {
        getUrlSession(type: .pork, numberTo: pageTo)
        categoryFirstBt.layer.borderColor = Color.backgroundColorCG
        categorySecondBt.layer.borderColor = Color.backgroundColorCG
        categoryThreeBt.layer.borderColor = Color.backgroundColorCG
        categoryForeBt.layer.borderColor = Color.backgroundColorCG
        categoryFirstBt.layer.borderWidth = NumberCGFloat.numberOneZero
        categoryFirstBt.layer.cornerRadius = categoryFirstBt.frame.size.height / NumberCGFloat.numberTwoZero
        categorySecondBt.layer.cornerRadius = categorySecondBt.frame.size.height / NumberCGFloat.numberTwoZero
        categoryThreeBt.layer.cornerRadius = categoryThreeBt.frame.size.height / NumberCGFloat.numberTwoZero
        categoryForeBt.layer.cornerRadius = categoryForeBt.frame.size.height / NumberCGFloat.numberTwoZero
    }
    private func borderBtVanishOrNo(typeFood: TypeFood){
        pageToZero()
        switch typeFood {
        case .chicken:
            categoryFirstBt.layer.borderWidth = NumberCGFloat.numberZero
            categorySecondBt.layer.borderWidth = NumberCGFloat.numberOneZero
            categoryThreeBt.layer.borderWidth = NumberCGFloat.numberZero
            categoryForeBt.layer.borderWidth = NumberCGFloat.numberZero
        case .beef:
            categoryFirstBt.layer.borderWidth = NumberCGFloat.numberZero
            categorySecondBt.layer.borderWidth = NumberCGFloat.numberZero
            categoryThreeBt.layer.borderWidth = NumberCGFloat.numberOneZero
            categoryForeBt.layer.borderWidth = NumberCGFloat.numberZero
        case .fish:
            categoryFirstBt.layer.borderWidth = NumberCGFloat.numberZero
            categorySecondBt.layer.borderWidth = NumberCGFloat.numberZero
            categoryThreeBt.layer.borderWidth = NumberCGFloat.numberZero
            categoryForeBt.layer.borderWidth = NumberCGFloat.numberOneZero
        default:
            categoryFirstBt.layer.borderWidth = NumberCGFloat.numberOneZero
            categorySecondBt.layer.borderWidth = NumberCGFloat.numberZero
            categoryThreeBt.layer.borderWidth = NumberCGFloat.numberZero
            categoryForeBt.layer.borderWidth = NumberCGFloat.numberZero
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row == recipes.count - NumberOther.numberOneInt { // last cell
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(NumberCGFloat.numberZero), y: CGFloat(NumberCGFloat.numberZero), width: tableView.bounds.width, height: CGFloat(144))
            self.tableView.tableFooterView = spinner
            pageTo += NumberOther.numberTenForTo
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



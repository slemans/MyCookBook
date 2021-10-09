//
//  DescriptionViewController.swift
//  MyCookBook
//
//  Created by sleman on 11.09.21.
//

import UIKit
import CoreData

//protocol DelegatReturnCollection: AnyObject {
//    func returnCollectionView(recipe: Favorite)
//}

class DescriptionViewController: UIViewController {

    @IBOutlet weak var imagesLb: UIImageView!
    @IBOutlet weak var nameProductLb: UILabel!
    @IBOutlet weak var timeСookingLb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackViewName: UIStackView!
    @IBOutlet weak var ingredientBt: UIButton!
    @IBOutlet weak var healthBt: UIButton!
    @IBOutlet weak var faloverBt: UIButton!
    @IBOutlet weak var stackViewMain: UIStackView!
    @IBOutlet weak var calLb: UILabel!
    @IBOutlet weak var fatLb: UILabel!
    @IBOutlet weak var carbLb: UILabel!
    @IBOutlet weak var fiverLb: UILabel!

    var recipel: Recipe!
    var flag = false
    var ingredientOrhealth = true
    var mainRecipeOrFavorite: Bool?
    var categoryFood: TypeFood?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fenchRecipe()
        startSetting()
        
    }
    public func startSetting() {
        calLb.text = String((Int(recipel.calories ?? 0) * 10) / 10)
        fatLb.text = tableviewFunction.returnToFullString(tip: "FAT", recipe: recipel)
        carbLb.text = tableviewFunction.returnToFullString(tip: "FIBTG", recipe: recipel)
        fiverLb.text = tableviewFunction.returnToFullString(tip: "CHOCDF", recipe: recipel)
        if mainRecipeOrFavorite == false {
            favoriteImage(bool: recipel.favorite)
        }
    }
   

    @IBAction func ingridientBtAction(_ sender: UIButton) {
        reload(first: sender, second: healthBt, bool: true)
    }
    @IBAction func healthBtAction(_ sender: UIButton) {
        reload(first: sender, second: ingredientBt, bool: false)
    }
    @IBAction func faloverBtActive(_ sender: UIButton) {
        if mainRecipeOrFavorite == true {
            if recipel?.favorite == nil{
                recipel?.favorite = true
                let newEncodedDataRecipe = try? JSONEncoder().encode(recipel)
                let newRecipe = Favorite(context: SettingCoreDate.context)
                newRecipe.label = recipel?.label
                newRecipe.image = recipel?.image
                newRecipe.categoryFood = findCategoryNumber()
                newRecipe.allfavoriteRecipe = newEncodedDataRecipe
                newRecipe.parentUser = SettingCoreDate.userCoreDate()
                SettingCoreDate.saveInCoreData()
            } else {
                recipel.favorite = !(recipel.favorite)!
            }
        } else {
            recipel.favorite = !(recipel.favorite)!
            navigationController?.popToRootViewController(animated: true)
            deleteRecipe()
        }
        favoriteImage(bool: recipel.favorite)
    }
    func deleteRecipe() {
        guard let label = recipel.label,
              let userUid = SettingCoreDate.getUserCoreDataUid() else { return }
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentUser.uid MATCHES %@", userUid)
        let itemPredicate = NSPredicate(format: "label MATCHES %@", label)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, itemPredicate])
        if let recipesFavorite = try?  SettingCoreDate.context.fetch(request) {
            for recipe in recipesFavorite {
                SettingCoreDate.context.delete(recipe)
            }
            SettingCoreDate.saveInCoreData()
        }
    }

    private func favoriteImage(bool: Bool?) {
        guard let bool = bool else { return }
        let image = UIImage(named: bool ? "icons8-heart-100Green.png" : "icons8-heart-100.png")
        self.faloverBt.setImage(image, for: .normal)
    }

    private func reload(first: UIButton, second: UIButton, bool: Bool) {
        first.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        first.tintColor = .white
        second.backgroundColor = .white
        second.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ingredientOrhealth = bool
        tableView.reloadData()
    }

    private func fenchRecipe() {
        putImage(image: recipel?.image)
        nameProductLb.text = recipel?.label
        timeСookingLb.text = tableviewFunction.returnTotalTimeString(time: recipel?.totalTime)
        stackViewMain.layer.borderWidth = Border.borderWidth
        stackViewMain.layer.borderColor = Color.backgroundColor
        stackViewMain.layer.cornerRadius = Border.borderRadius15
        tableView.layer.cornerRadius = Border.borderRadius15
        title = recipel?.label
    }
    private func putImage(image: String?) {
        guard let image = image,
            let urlImg = URL(string: image) else { return }
        URLSession.shared.dataTask(with: urlImg) { data, _, _ in
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imagesLb.image = image
                    }
                }
            }
        }.resume()
    }
    public func findCategoryNumber() -> Int16{
        var categoryFoodNumber = 0
        switch categoryFood {
        case .chicken:
            categoryFoodNumber = 1
        case .beef:
            categoryFoodNumber = 2
        case .fish:
            categoryFoodNumber = 3
        default:
            categoryFoodNumber = 0
        }
        return Int16(categoryFoodNumber)
    }
}

extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = recipel?.ingredients.count,
              let healthLabels = recipel?.healthLabels.count else { return 0 }
        return ingredientOrhealth == true ? ingredients : healthLabels
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath)
        if ingredientOrhealth == true,
            let ingridient = recipel?.ingredients[indexPath.row] {
            cell.textLabel?.text = ingridient.text
        } else if let health = recipel?.healthLabels[indexPath.row] {
            cell.textLabel?.text = health
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}



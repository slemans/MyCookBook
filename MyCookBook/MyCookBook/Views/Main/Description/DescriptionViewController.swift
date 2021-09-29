//
//  DescriptionViewController.swift
//  MyCookBook
//
//  Created by sleman on 11.09.21.
//

import UIKit

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

    var recipel: Recipe?
    var recipeFavorite: Favorite?
    var flag = false
    var ingredientOrhealth = true
    var recipeOrFavoriteRecipe: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("представление DescriptionViewController: \(recipel)")
        fenchRecipe()
        startSetting()
    }
    public func startSetting() {
        if recipeOrFavoriteRecipe == true {
            if recipel != nil, let recipel = recipel {
                calLb.text = String((Int(recipel.calories) * 10) / 10)
                fatLb.text = tableviewFunction.returnToFullString(tip: "FAT", recipe: recipel)
                carbLb.text = tableviewFunction.returnToFullString(tip: "FIBTG", recipe: recipel)
                fiverLb.text = tableviewFunction.returnToFullString(tip: "CHOCDF", recipe: recipel)
            }
        } else {

        }

    }


    @IBAction func ingridientBtAction(_ sender: UIButton) {
        reload(first: sender, second: healthBt, bool: true)
    }
    @IBAction func healthBtAction(_ sender: UIButton) {
        reload(first: sender, second: ingredientBt, bool: false)
    }
    @IBAction func faloverBtActive(_ sender: UIButton) {

        if recipel?.favorite == nil {
            recipel?.favorite = true
//            let newEncodedDataRecipe = try? JSONEncoder().encode(recipel)
//            let newRecipe = Favorite(context: SettingCoreDate.context)
//            newRecipe.label = recipel?.label
//            newRecipe.image = recipel?.image
//            newRecipe.allfavoriteRecipe = newEncodedDataRecipe
//            newRecipe.parentUser = SettingCoreDate.userCoreDate()
//            SettingCoreDate.saveInCoreData()


            let demo = Recipe(favorite: true, label: "Demo", image: "images", totalTime: 8, mealType: [nil], totalNutrients: ["demo total 1": Total(label: "demoTotal2", quantity: 2, unit: .g)], calories: 22, ingredients: [Ingredient(text: "Ingredient demo")], healthLabels: [String("healthLabels demo")])
            print("Старт кодирования \(demo)")
            let newEncodedDataRecipe = try? JSONEncoder().encode(demo)
            print("Закодировал \(newEncodedDataRecipe)")
            guard let newEncodedDataRecipe = newEncodedDataRecipe else { return }
            let favoriteRecipe = try? JSONDecoder().decode(Recipe.self, from: newEncodedDataRecipe)
            print("получил данные \(favoriteRecipe)")


        } else {
            recipel?.favorite = !(recipel?.favorite)!
        }
        favoriteImage(bool: recipel?.favorite)
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
        timeСookingLb.text = totalTime(time: recipel?.totalTime)
        stackViewMain.layer.borderWidth = Border.borderWidth
        stackViewMain.layer.borderColor = Color.backgroundColor
        stackViewMain.layer.cornerRadius = Border.borderRadius15
        tableView.layer.cornerRadius = Border.borderRadius15
        title = recipel?.label

    }
    private func totalTime(time: Int?) -> String {
        if time != 0, let time = time {
            return "\(time) minutes"
        } else {
            return "time not unknown"
        }

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
}

extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ingredientOrhealth == true ? recipel.ingredients.count : recipel.healthLabels.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = recipel?.ingredients?.count,
            let healthLabels = recipel?.healthLabels?.count else { return 0 }
        return ingredientOrhealth == true ? ingredients : healthLabels
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath)
        if ingredientOrhealth == true,
            let ingridient = recipel?.ingredients?[indexPath.row] {
            cell.textLabel?.text = ingridient.text
        } else if let health = recipel?.healthLabels?[indexPath.row] {
            cell.textLabel?.text = health
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}



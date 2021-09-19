//
//  DescriptionViewController.swift
//  MyCookBook
//
//  Created by sleman on 11.09.21.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        fenchRecipe()
        calLb.text = String((Int(recipel.calories) * 10) / 10)
        fatLb.text = tableviewFunction.returnToFullString(tip: "FAT", recipe: recipel)
        carbLb.text = tableviewFunction.returnToFullString(tip: "FIBTG", recipe: recipel)
        fiverLb.text = tableviewFunction.returnToFullString(tip: "CHOCDF", recipe: recipel)
    }

    @IBAction func ingridientBtAction(_ sender: UIButton) {
        reload(first: sender, second: healthBt, bool: true)
    }
    @IBAction func healthBtAction(_ sender: UIButton) {
        reload(first: sender, second: ingredientBt, bool: false)
    }
    @IBAction func faloverBtActive(_ sender: UIButton) {
        if recipel.favorite == nil{
            recipel.favorite = true
        } else {
            recipel.favorite = !recipel.favorite!
        }
        favoriteImage(bool: recipel.favorite)
    }
    
    private func favoriteImage(bool: Bool?){
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
        putImage(image: recipel.image)
        nameProductLb.text = recipel.label
        timeСookingLb.text = totalTime(time: recipel.totalTime)
        stackViewMain.layer.borderWidth = Border.borderWidth
        stackViewMain.layer.borderColor = Color.backgroundColor
        stackViewMain.layer.cornerRadius = Border.borderRadius15
        tableView.layer.cornerRadius = Border.borderRadius15
        title = recipel.label

    }
    private func totalTime(time: Int?) -> String {
        if time != 0 {
            return "\(time!) minutes"
        } else {
            return "time not unknown"
        }

    }
    private func putImage(image: String) {
        guard let urlImg = URL(string: image) else { return }
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientOrhealth == true ? recipel.ingredients.count : recipel.healthLabels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath)
        if ingredientOrhealth == true {
            let ingridient = recipel.ingredients[indexPath.row]
            cell.textLabel?.text = ingridient.text
        } else {
            let health = recipel.healthLabels[indexPath.row]
            cell.textLabel?.text = health
        }
        return cell
    }
}

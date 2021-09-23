//
//  ProfileVC.swift
//  MyCookBook
//
//  Created by sleman on 30.08.21.
//

import UIKit
import Firebase
import CoreData

class ProfileVC: UIViewController {

    @IBOutlet weak var nameUserLb: UILabel!
    @IBOutlet weak var logOutBt: UIButton!
    @IBOutlet weak var imagesUser: UIImageView!
    @IBOutlet weak var myRecipeLb: UILabel!
    @IBOutlet weak var favoritesLb: UILabel!
    @IBOutlet weak var noNameLb: UILabel!

//    let context = SettingCoreDate.getContext()
//    var users: [User] = []
    var ourUser: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchUser()
        openingSeting()

        // посмотерть всех users
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        do {
//            users = try context.fetch(fetchRequest)
//        } catch {
//            print(error.localizedDescription)
//        }
//        for one in users {
//            print(one.email)
//        }

    }

    private func searchUser() {
        let request: NSFetchRequest<User> = User.fetchRequest()
//        if let user = FirebaseServise.searchUserFirebase(){
            let searchPredicate = NSPredicate(format: "uid CONTAINS[cd] %@", FirebaseServise.searchUserFirebase())
            request.sortDescriptors = [NSSortDescriptor(key: "uid", ascending: true)]
            request.predicate = searchPredicate
            do {
                ourUser = try SettingCoreDate.context.fetch(request)
            } catch {
                print("Error fetching data from context: \(error)")
            }
//        } else {
//            print("error: no User")
//        }
        
    }



    @IBAction func editeuserAct(_ sender: UIBarButtonItem) {

// метод удаления временный
//        let request: NSFetchRequest<User> = User.fetchRequest()
//        request.predicate = NSPredicate(format: "email MATCHES %@", "demo3@demo.ru")
//        if let categories = try? SettingCoreDate.context.fetch(request) {
//            for category in categories {
//                print(category.email)
//                SettingCoreDate.context.delete(category)
//            }
//        }
//        do {
//            try SettingCoreDate.context.save()
//        } catch {
//            print("Error saving context: \(error)")
//        }
    }
    @IBAction func goOutBtAct() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    fileprivate func openingSeting() {
        if ourUser[0].name != "" {
            nameUserLb.text = ourUser[0].name
        } else {
            noNameLb.text = "You didn't write your name"
            nameUserLb.text = ""
        }
        if let numberCountMyRecipe = ourUser[.zero].myRecipes?.count,
           let numberCountFavorite = ourUser[.zero].favorites?.count{
            myRecipeLb.text = String(numberCountMyRecipe)
            favoritesLb.text = String(numberCountFavorite)
        }
        logOutBt.layer.cornerRadius = Border.borderRadius
        imagesUser.layer.cornerRadius = Border.borderRadius
    }





}

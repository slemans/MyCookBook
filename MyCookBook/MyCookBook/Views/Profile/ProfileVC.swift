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

    let context = SettingCoreDate.getContext()
    var users: [User] = []
    var ourUser: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchUser()
        openingSeting()

        // посмотерть всех users
//        let context = SettingCoreDate.getContext()
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
        let context = SettingCoreDate.getContext()
        let userUid = Auth.auth().currentUser!.uid
        let request: NSFetchRequest<User> = User.fetchRequest()
        let searchPredicate = NSPredicate(format: "uid CONTAINS[cd] %@", userUid)
        request.sortDescriptors = [NSSortDescriptor(key: "uid", ascending: true)]
        request.predicate = searchPredicate
        do {
            ourUser = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }


    @IBAction func clickImages(_ sender: UIGestureRecognizer) {
        print("нажал на images")
    }
    @IBAction func clickImagesTwo(_ sender: UITapGestureRecognizer) {
        print("нажал на images2")
    }

    @IBAction func editeuserAct(_ sender: UIBarButtonItem) {

// метод удаления временный
//        let request: NSFetchRequest<User> = User.fetchRequest()
//        request.predicate = NSPredicate(format: "email MATCHES %@", "demo2@demo.ru")
//        if let categories = try? context.fetch(request) {
//            for category in categories {
//                print(category.email)
//                context.delete(category)
//            }
//        }
//        do {
//            try self.context.save()
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
        if let numberCountMyRecipe = ourUser[0].myRecipes?.count,
           let numberCountFavorite = ourUser[0].favorites?.count{
            myRecipeLb.text = String(numberCountMyRecipe)
            favoritesLb.text = String(numberCountFavorite)
        }
        logOutBt.layer.cornerRadius = Border.borderRadius
        imagesUser.layer.cornerRadius = Border.borderRadius
    }





}

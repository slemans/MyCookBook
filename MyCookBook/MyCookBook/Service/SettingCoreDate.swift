//
//  SettingCoreDate.swift
//  MyCookBook
//
//  Created by sleman on 21.09.21.
//

import CoreData
import UIKit


struct SettingCoreDate {

    static let context = SettingCoreDate.getContext()

    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    static func saveInCoreData() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    static func requestUidUser() -> NSFetchRequest<User> {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let searchPredicate = NSPredicate(format: "uid CONTAINS[cd] %@", FirebaseServise.searchUserFirebase())
        request.sortDescriptors = [NSSortDescriptor(key: "uid", ascending: true)]
        request.predicate = searchPredicate
        return request
    }
    // get UserUidCoreData
    static func getUserCoreDataUid() -> String? {
        do {
            let users = try context.fetch(requestUidUser())
            return users[.zero].uid
        } catch {
            print("Error fetching data from context: \(error)")
            return nil
        }
    }

    // find UserCoreData
    static func userCoreDate() -> User {
        var users: [User] = []
        do {
            users = try context.fetch(SettingCoreDate.requestUidUser())
        } catch {
            print("Error fetching data from context: \(error)")
        }
        return users[.zero]
    }

    static func getMyRecipes() -> [MyRecipe]? {
        let request: NSFetchRequest<MyRecipe> = MyRecipe.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentUser.uid MATCHES %@", FirebaseServise.searchUserFirebase())
        request.predicate = categoryPredicate
        do {
            let recipes = try SettingCoreDate.context.fetch(request)
            return recipes
        } catch {
            print("Error fetching data from context: \(error)")
            return nil
        }
    }
    static func getFavorite() -> [Favorite]? {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentUser.uid MATCHES %@", FirebaseServise.searchUserFirebase())
        request.predicate = categoryPredicate
        do {
            let recipes = try SettingCoreDate.context.fetch(request)
            return recipes
        } catch {
            print("Error fetching data from context: \(error)")
            return nil
        }
    }
}

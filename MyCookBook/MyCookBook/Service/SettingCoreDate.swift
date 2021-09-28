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
    static func requestUidUser() -> NSFetchRequest<User>{
        let request: NSFetchRequest<User> = User.fetchRequest()
        let searchPredicate = NSPredicate(format: "uid CONTAINS[cd] %@", FirebaseServise.searchUserFirebase())
        request.sortDescriptors = [NSSortDescriptor(key: "uid", ascending: true)]
        request.predicate = searchPredicate
        return request
    }
    
    static func userCoreDate() -> User{
        var users: [User] = []
        do {
            users = try context.fetch(SettingCoreDate.requestUidUser())
        } catch {
            print("Error fetching data from context: \(error)")
        }
        return users[.zero]
    }
    

}

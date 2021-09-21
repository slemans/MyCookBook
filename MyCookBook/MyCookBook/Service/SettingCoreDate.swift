//
//  SettingCoreDate.swift
//  MyCookBook
//
//  Created by sleman on 21.09.21.
//

import CoreData
import UIKit


struct SettingCoreDate {
    static func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

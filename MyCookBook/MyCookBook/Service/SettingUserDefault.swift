//
//  UserDefault.swift
//  MyCookBook
//
//  Created by sleman on 6.10.21.
//

import Foundation

class SettingUserDefault{
    static let shared = SettingUserDefault()
    func inNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}

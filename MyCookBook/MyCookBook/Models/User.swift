//
//  User.swift
//  MyCookBook
//
//  Created by sleman on 28.08.21.
//

import Foundation
import Firebase

struct User {
    // MARK: Lifecycle
    
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email ?? ""
        self.name = user.phoneNumber
    }
    init(useruid: String, email: String, name: String){
        self.name = name
        self.email = email
        self.uid = useruid
    }
    // MARK: Internal

    // идентификатор пользователя
    let uid: String
    let email: String
    let name: String?
}


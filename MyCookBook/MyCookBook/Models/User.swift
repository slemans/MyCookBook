//
//  User.swift
//  MyCookBook
//
//  Created by sleman on 28.08.21.
//

import Foundation
import Firebase

struct Users {
    let uid: String
    let name: String?
    let email: String
    //let recepets: Recipe?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email!
        self.name = user.displayName
    }
    
}


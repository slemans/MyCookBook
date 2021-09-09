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
    }

    // MARK: Internal

    // идентификатор пользователя
    let uid: String
    let email: String
}


//
//  FirebaseServise.swift
//  MyCookBook
//
//  Created by sleman on 22.09.21.
//

import Firebase
import UIKit

struct FirebaseServise {
    static func searchUserFirebase() -> String {
        guard let userID = Auth.auth().currentUser?.uid else { return ""}
        return userID
    }
 
    static func logOutUserFirebase() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }

}

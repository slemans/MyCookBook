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
//        guard let userID = Auth.auth().currentUser?.uid else { return nil}
         let userID = Auth.auth().currentUser!.uid
        return userID
    }
}

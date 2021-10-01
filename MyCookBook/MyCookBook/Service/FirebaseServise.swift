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
    static func logOutUserFirebase() {
        do {
            try Auth.auth().signOut()
//            navigationController?.popToRootViewController(animated: true)
//            dismiss(animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }

}

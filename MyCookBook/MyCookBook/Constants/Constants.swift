//
//  Constants.swift
//  MyCookBook
//
//  Created by sleman on 1.09.21.
//

import Foundation

struct Constants {
    enum Segues {
        static let singIn = "singInSegue"
        static let singUp = "singUpSegue"
        static let start = "thankYouSegue"
        static let addNewRecipe = "SegueFullRecipe"
    }
    enum viewControllerId{
        static let singInVC = "SingInVC"
        static let startNavigation = "StartNavigation"
        static let tabBarVC = "TabBarViewController"
    }
    enum storyboardName{
        static let singIn = "SingIn"
        static let tabBar = "TabBar"
    }
    
}

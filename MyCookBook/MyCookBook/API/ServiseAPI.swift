//
//  ServiseAPI.swift
//  MyCookBook
//
//  Created by sleman on 25.08.21.
//

import Foundation
import SwiftyJSON

class ServiseAPI {
    fileprivate let headers = [
        "x-rapidapi-host": "edamam-recipe-search.p.rapidapi.com",
        "x-rapidapi-key": "a9251ae6d4msh7bffd76584bf303p1fed23jsn21bc8922aab6"
    ]


    func fetchUrlSession(forType type: TypeFood, numberTo: Int, completionHandler: @escaping (Recipes) -> Void) {
        var url = ""
        switch type {
        case .chicken:
            url = "https://edamam-recipe-search.p.rapidapi.com/search?q=chicken&to=\(numberTo)"
        case .pork:
            url = "https://edamam-recipe-search.p.rapidapi.com/search?q=pork&to=\(numberTo)"
        case .beef:
            url = "https://edamam-recipe-search.p.rapidapi.com/search?q=beef&to=\(numberTo)"
        case .fish:
            url = "https://edamam-recipe-search.p.rapidapi.com/search?q=fish&to=\(numberTo)"
        }
        let request = NSMutableURLRequest(url: NSURL(
            string: "\(url)")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { [weak self] data, response, error in
            if let data = data, let myRecipes = self?.parseJSON(withData: data) {
                completionHandler(myRecipes)
            }
        }
        task.resume()
    }

    fileprivate func parseJSON(withData data: Data) -> Recipes? {
        let decoder = JSONDecoder()
        do {
            let recipes = try decoder.decode(Recipes.self, from: data)
            guard let recipe = Recipes(recipe: recipes) else { return nil }
            return recipe
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }

}

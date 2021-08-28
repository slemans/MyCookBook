//
//  FavoriteCVC.swift
//  MyCookBook
//
//  Created by sleman on 25.08.21.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class FavoriteCVC: UICollectionViewController {

    private var favorites: [Recipe] = []
    private var hits: [JSON] = []
    private var alboms: JSON? = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //gethData()
        getTwo()
        // getTwoT()
    }
    override func viewWillAppear(_ animated: Bool) {
//        favorites = alboms["hits"].arrayValue
    }




//    func gethData() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/") else { return }
//
//        AF.request(url, requestModifier: { $0.timeoutInterval = 10.0 }).responseJSON { response in
//            switch response.result {
//            case .success(let data):
//                print(JSON(data))
//                //self.favorites = JSON(data).arrayValue
//                self.collectionView.reloadData()
//                print(self.favorites.count)
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//
//    }
    func getTwo() {

        let headers = [
            "x-rapidapi-host": "edamam-recipe-search.p.rapidapi.com",
            "x-rapidapi-key": "eba0823ae8msh6033297465cdf65p145577jsn53c564785219"
        ]

        let hTTPHeaders: HTTPHeaders = HTTPHeaders(headers)
        guard let url = URL(string: "https://edamam-recipe-search.p.rapidapi.com/search?q=chicken") else { return }
        AF.request(url,
            method: .get,
            headers: hTTPHeaders,
            requestModifier: { $0.timeoutInterval = 10.0 }
        ).responseJSON { response in
            switch response.result {
            case .success(let data):
                self.hits = JSON(data).arrayValue
                self.collectionView.reloadData()
            case .failure(let error):
                print("нет ответа", error)
            }
        }
    }
    
    
    
    
    
    
//    func getTwoT() {
//
//        let headers = [
//            "x-rapidapi-host": "edamam-recipe-search.p.rapidapi.com",
//            "x-rapidapi-key": "eba0823ae8msh6033297465cdf65p145577jsn53c564785219"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(
//            string: "https://edamam-recipe-search.p.rapidapi.com/search?q=chicken")! as URL,
//            cachePolicy: .useProtocolCachePolicy,
//            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, _) -> Void in
//            guard let data = data else { return }
//            do {
//
//                self.favorites = try JSONDecoder().decode([Recipe].self, from: data)
//                print(self.favorites.count)
//            } catch {
//                print("Загрузка Albom ", error)
//            }
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        })
//
//        dataTask.resume()
//    }





    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return favorites.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        let recipe = favorites[indexPath.row]

        cell.configure(user: "привет")



        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

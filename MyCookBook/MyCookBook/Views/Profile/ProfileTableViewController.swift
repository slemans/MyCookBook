//
//  ProfileTableViewController.swift
//  MyCookBook
//
//  Created by sleman on 26.09.21.
//

import Firebase
import UIKit
import CoreData

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var nameUserLb: UILabel!
    @IBOutlet weak var myRecipeLb: UILabel!
    @IBOutlet weak var favoritesLb: UILabel!
    @IBOutlet weak var noNameLb: UILabel!
    @IBOutlet weak var imagesProfileUser: UIImageView!


    var user: User! {
        SettingCoreDate.userCoreDate()
    }
    var imageIsChanged = false
    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
    }
    override func viewWillAppear(_ animated: Bool) {
        findeFavoriteAndMyRecipeCount()
        tableView.reloadData()
    }
    @IBAction func logOutBtAct(_ sender: UIBarButtonItem) {
        FirebaseServise.logOutUserFirebase()
        navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    public func startSetting() {
        if user?.images != nil {
            imagesProfileUser.image = UIImage(data: (user?.images)!)
            imagesProfileUser.contentMode = .scaleAspectFill
        }
        if user.name != "" {
            nameUserLb.text = user.name
            nameUserLb.textColor = .black
        } else {
            noNameLb.text = "You didn't write your name"
            nameUserLb.text = "Write name"
            nameUserLb.textColor = .red
        }
        findeFavoriteAndMyRecipeCount()
        tableView.tableFooterView = UIView()
    }
    public func findeFavoriteAndMyRecipeCount() {
        if let numberCountMyRecipe = user.myRecipes?.count,
            let numberCountFavorite = user.favorites?.count {
            myRecipeLb.text = String(numberCountMyRecipe)
            favoritesLb.text = String(numberCountFavorite)
        }
    }
    public func userImagesAndName(image: UIImage?, name: String?) {
        if image != nil {
            let imageDate = image?.pngData()
            user.images = imageDate
        }
        if name != nil {
            user.name = name
        }
        SettingCoreDate.saveInCoreData()
    }
}

// MARK: - Table view data source
extension ProfileTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            let actionSheet = UIAlertController(title: nil,
                message: nil,
                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.cooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.cooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
        } else if indexPath.row == 1 {
            let alert = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Ivan"
            }
            let search = UIAlertAction(title: "Save", style: .default) { action in
                let textField = alert.textFields?.first
                guard let userNameNew = textField?.text else { return }
                if userNameNew != "" {
                    self.nameUserLb.text = userNameNew
                    self.nameUserLb.textColor = .black
                    self.noNameLb.text = "good to see you!"
                    self.userImagesAndName(image: nil, name: userNameNew)
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(cancel)
            alert.addAction(search)
            present(alert, animated: true, completion: nil)
        } else {
            view.endEditing(true)
        }
    }
}


// MARK: Work with image
extension ProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//     select what we open and allow to edit the image
    func cooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    // put in UIImages photo user 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagesProfileUser.image = info[.editedImage] as? UIImage
        imagesProfileUser.contentMode = .scaleAspectFill
        imagesProfileUser.clipsToBounds = true // обрезка фото по границу Lb
        imageIsChanged = true
        userImagesAndName(image: info[.editedImage] as? UIImage, name: nil)
        dismiss(animated: true)
    }
}

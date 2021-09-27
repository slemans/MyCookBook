//
//  AddNewRecipeTableViewController.swift
//  MyCookBook
//
//  Created by sleman on 19.09.21.
//

import UIKit
import CoreData
import Firebase

protocol DelegatReturnTable: AnyObject {
    func returnTableReview(recipe: MyRecipe)
}

class AddNewRecipeTableViewController: UITableViewController {

    @IBOutlet weak var imagesFood: UIImageView!
    @IBOutlet weak var saveBt: UIBarButtonItem!
    @IBOutlet weak var caloriesTf: UITextField!
    @IBOutlet weak var IngredientsTf: UIStackView!
    @IBOutlet weak var totalTimeTf: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var ingredientTf: UITextField!
    
    var selectedUser: User?
    var recipe: MyRecipe?
    weak var delegate: DelegatReturnTable?

    let userUid = Auth.auth().currentUser!.uid
    var imageIsChanged = false

    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
    }
    
    @IBAction func cencelBtAct(_ sender: UIBarButtonItem) {
        returnToBack()
    }
    @IBAction func saveBtAct(_ sender: Any) {
        let image: UIImage? = imageIsChanged ? imagesFood.image: #imageLiteral(resourceName: "imagePlaceholder")
        let imageDate = image?.pngData()
        let newMyrecipe = MyRecipe(context: SettingCoreDate.context)
        newMyrecipe.name = nameTf.text
        newMyrecipe.images = imageDate
        newMyrecipe.parentUser = selectedUser
        newMyrecipe.totalTime = totalTimeTf.text
        newMyrecipe.calories = caloriesTf.text
        newMyrecipe.ingridients = ingredientTf.text
        newMyrecipe.parentUser = selectedUser
        delegate?.returnTableReview(recipe: newMyrecipe)
        SettingCoreDate.saveInCoreData()
        returnToBack()
    }


    public func startSetting() {
        if recipe != nil {
            nameTf.text = recipe?.name
            imagesFood.image = UIImage(data: (recipe?.images)!)
            caloriesTf.text = recipe?.calories
            totalTimeTf.text = recipe?.totalTime
            ingredientTf.text = recipe?.ingridients
            if isEqualToImage(recipe?.images) != true {
                imagesFood.contentMode = .scaleAspectFill
            } else {
                imagesFood.contentMode = .scaleAspectFit
            }
        }
        tableView.tableFooterView = UIView() // убираем лишние cell
        saveBt.isEnabled = false
        nameTf.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    private func isEqualToImage(_ image: Data?) -> Bool {
        let data1 = image
        let data2 = #imageLiteral(resourceName: "imagePlaceholder").pngData()
        return data1 == data2
    }
    private func returnToBack() {
        navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true)
    }

}

// MARK: - Table view data source
extension AddNewRecipeTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            let actionSheet = UIAlertController(title: nil,
                message: nil,
                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                // вызов метода с изображение камеры
                self.cooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            //camera.setValue(CATextLayerAlignmentMode.left, forKey: "Camera")
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                // вызов imagePicker
                self.cooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
}

extension AddNewRecipeTableViewController: UITextFieldDelegate {
    // remove keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // проверка на пустое имя
    @objc private func textFieldChanged() {
        if nameTf.text?.isEmpty == false {
            saveBt.isEnabled = true
        } else {
            saveBt.isEnabled = false
        }
    }
}

// MARK: Work with image
extension AddNewRecipeTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // выбор что открываем, и разрешаем редактировать изображение
    func cooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }

    // вставляем в UIImages фото пользователя
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagesFood.image = info[.editedImage] as? UIImage
        imagesFood.contentMode = .scaleAspectFill
        imagesFood.clipsToBounds = true // обрезка фото по границу Lb
        imageIsChanged = true
        dismiss(animated: true)
    }

}

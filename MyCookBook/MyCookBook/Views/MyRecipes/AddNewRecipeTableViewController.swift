//
//  AddNewRecipeTableViewController.swift
//  MyCookBook
//
//  Created by sleman on 19.09.21.
//

import UIKit

class AddNewRecipeTableViewController: UITableViewController {

    @IBOutlet weak var imagesFood: UIImageView!
    @IBOutlet weak var saveBt: UIBarButtonItem!
    @IBOutlet weak var caloriesTf: UITextField!
    @IBOutlet weak var IngredientsTf: UIStackView!
    @IBOutlet weak var totalTimeTf: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    
    var newRecipe: MyRecipeTwo?
    var imageIsChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView() // убираем лишние cell
        saveBt.isEnabled = false
        nameTf.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
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
    
    // MARK: - Table view data source

    @IBAction func cencelBtAct(_ sender: UIBarButtonItem) {
        returnToBack()
    }
    @IBAction func saveBtAct(_ sender: Any) {
        var image: UIImage?
        if imageIsChanged{
            image = imagesFood.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        newRecipe = MyRecipeTwo(label: nameTf.text!, image: image, totalTime: Int(totalTimeTf.text!), calories: Double(caloriesTf.text!))
        // добавить в базу данных новое значение
        
        returnToBack()
    }
    private func returnToBack(){
        navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true)
    }

}

extension AddNewRecipeTableViewController: UITextFieldDelegate {
    // remove keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // проверка на пустое имя
    @objc private func textFieldChanged(){
        if nameTf.text?.isEmpty == false{
            saveBt.isEnabled = true
        } else {
            saveBt.isEnabled = false
        }
    }
}

// MARK: Work with image
extension AddNewRecipeTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // выбор что открываем, и разрешаем редактировать изображение
    func cooseImagePicker(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    // вставляем в UIImages фото пользователя
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagesFood.image = info[.editedImage] as? UIImage
        imagesFood.contentMode = .scaleAspectFill
        imagesFood.clipsToBounds = true // обрезка фото по границу Lb
        imageIsChanged = true
        dismiss(animated: true)
    }
    
}

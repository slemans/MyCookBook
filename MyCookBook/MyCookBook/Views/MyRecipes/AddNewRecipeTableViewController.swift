//
//  AddNewRecipeTableViewController.swift
//  MyCookBook
//
//  Created by sleman on 19.09.21.
//

import UIKit

class AddNewRecipeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView() // убираем лишние cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
        } else {
            view.endEditing(true)
        }
    }
    
    // MARK: - Table view data source

    @IBAction func cencelBtAct(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func saveBtAct(_ sender: Any) {

    }

}

extension AddNewRecipeTableViewController: UITextFieldDelegate {
    // remove keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//
//  NoteDetailViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var gameNameField: UITextField!
    @IBOutlet weak var gameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private let viewModel = NoteDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func saveButtonPressed(_ sender: Any) {
        if gameNameField.text != "" && gameTextField.text != "" {
            let myNote = NoteCellModel(name: gameNameField.text!, note: gameTextField.text!, date: Date())
            viewModel.saveNote(myNote)
            
            dismiss(animated: true, completion: nil)
            //navigationController?.popViewController(animated: true)
        } else {
            showAlert()
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Empty Fields", message: "Please fill all fields before saving", preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

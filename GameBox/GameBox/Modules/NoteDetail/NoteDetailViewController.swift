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
//            let noteVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: NoteViewController.self)) as? NoteViewController
            dismiss(animated: true, completion: nil)
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

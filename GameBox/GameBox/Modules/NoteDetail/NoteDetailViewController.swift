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
    private var items: [NoteCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        viewModel.didViewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if gameNameField.text != "" && gameTextField.text != "" {
            let myNote = NoteCellModel(name: gameNameField.text!, note: gameTextField.text!, date: Date())
            viewModel.saveNote(myNote)
            dismiss(animated: true, completion: nil)
//            dismiss(animated: true, completion: {
//                firstVC.didClosureArrive(data: self.gatherData())
//            })
        } else {
            showAlert()
        }
    }
}

//MARK: - NoteDetailVC Extension
extension NoteDetailViewController {

    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }

        viewModel.refreshItems = { [weak self] items in
            self?.setItems(items)
        }
    }
    
    func setItems(_ items: [NoteCellModel]) {
        self.items = items
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Empty Fields", message: "Please fill all fields before saving.", preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

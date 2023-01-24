//
//  NoteViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import UIKit

class NoteViewController: UIViewController {
    
    
    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var notetBarItem: UIBarButtonItem!
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bigBookImage: UIImageView!
    
    let viewModel = NoteViewModel()
    private var tableHelper: NoteVCHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.didViewLoad()
        setupBinding()
    }
    
    @IBAction func deleteAllNotes(_ sender: Any) {
        showAlert()
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "noteSegue", sender: self)
    }
}

//MARK: - NoteVC Extension
extension NoteViewController: canGoNote {
    
    private func setupUI() {
        tableHelper = .init(tableView: noteTableView, viewModel: viewModel)
        tableHelper.delegate = self
        
        self.title = "Notes".localized()
        notetBarItem.title = "Add Note".localized()
        bookLabel.text = "No Note Taken Yet".localized()
        bookLabel.alpha = 0.5
        bigBookImage.alpha = 0.5
    }
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert".localized(), message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }

        viewModel.refreshItems = { [weak self] items in
            self?.tableHelper.setItems(items)
            
            if items.count != 0 {
                self?.bigBookImage.isHidden = true
                self?.bookLabel.isHidden = true
                self?.noteTableView.isHidden = false
            } else {
                self?.bigBookImage.isHidden = false
                self?.bookLabel.isHidden = false
                self?.noteTableView.isHidden = true
            }
        }
    }
    
    func goToNoteDetail(_ noteData: NoteCellModel) {
        guard let noteDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: NoteDetailViewController.self)) as? NoteDetailViewController
                else { return }
        
        present(noteDetailVC, animated: true, completion: {
            noteDetailVC.gameNameField.text = noteData.name
            noteDetailVC.gameTextField.text = noteData.note
        })
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Delete All".localized(), message: "All notes will be deleted \n Are you sure?".localized(), preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete".localized(), style: .destructive) {
                UIAlertAction in
            self.viewModel.deleteAll()
            }
        
        alertController.addAction(deleteAction)
        alertController.addAction(.init(title: "Cancel".localized(), style: .default))
        present(alertController, animated: true)
    }
}

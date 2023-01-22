//
//  NoteViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import UIKit

class NoteViewController: UIViewController {
    
    
    @IBOutlet weak var noteTableView: UITableView!
    
    let viewModel = NoteViewModel()
    private var tableHelper: NoteVCHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("a")
        setupUI()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("b")
        viewModel.didViewLoad()
        setupBinding()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        print("c")
//        viewModel.didViewLoad()
//        setupUI()
//        setupBinding()
//    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        guard let noteDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: NoteDetailViewController.self)) as? NoteDetailViewController
        else { return }
        
        //self.navigationController?.pushViewController(noteDetailVC, animated: true)
        present(noteDetailVC, animated: true)
    }
}

//MARK: - NoteVC Extension
extension NoteViewController: canGoNote {
    
    private func setupUI() {
        tableHelper = .init(tableView: noteTableView, viewModel: viewModel)
        tableHelper.delegate = self
    }
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }

        viewModel.refreshItems = { [weak self] items in
            self?.tableHelper.setItems(items)
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
}

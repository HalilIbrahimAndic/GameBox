//
//  NoteDetailViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit

class NoteDetailViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    // Outlets
    @IBOutlet weak var gameNameField: UITextField!
    @IBOutlet weak var gameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameTextLabel: UILabel!
    
    private let viewModel = NoteDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.titleLabel?.text = "Save".localized()
        gameNameLabel.text = "Game Name".localized()
        gameTextLabel.text = "Note:".localized()
        gameTextField.placeholder = "Write your note here...".localized()
        
        // calls observer for notification
        localNotification()
    }
 
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        UNUserNotificationCenter.current().delegate = self
        
        // makes sure fields are not empty
        if gameNameField.text != "" && gameTextField.text != "" {
            let myNote = NoteCellModel(name: gameNameField.text!, note: gameTextField.text!, date: Date())
            viewModel.saveNote(myNote)
            
            // posts notification
            NotificationCenter.default.post(name: Notification.Name("NoteNotification"), object: nil)
            dismiss(animated: true, completion: nil)
        } else {
            showAlert()
        }
    }
}

//MARK: - Extension for notifications
extension NoteDetailViewController {
    
    func localNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(newNoteSaved), name: Notification.Name("NoteNotification"), object: nil)
    }
    
    @objc func newNoteSaved() {
        let notificationManager: NotificationProtocol = LocalNotificationManager.shared
        notificationManager.sendNotification(title: "New Note!".localized(), message: "Your note is saved and listed.".localized())
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner, .badge, .list])
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Empty Fields".localized(), message: "Please fill all fields before saving".localized(), preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

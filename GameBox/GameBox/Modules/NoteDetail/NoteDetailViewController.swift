//
//  NoteDetailViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit

class NoteDetailViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var gameNameField: UITextField!
    @IBOutlet weak var gameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private let viewModel = NoteDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func saveButtonPressed(_ sender: Any) {
        localNotification()
        UNUserNotificationCenter.current().delegate = self
        
        if gameNameField.text != "" && gameTextField.text != "" {
            let myNote = NoteCellModel(name: gameNameField.text!, note: gameTextField.text!, date: Date())
            viewModel.saveNote(myNote)
            
            NotificationCenter.default.post(name: Notification.Name("NoteNotification"), object: nil)
            dismiss(animated: true, completion: nil)
        } else {
            showAlert()
        }
    }
}

extension NoteDetailViewController {
    
    func localNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(newNoteSaved), name: Notification.Name("NoteNotification"), object: nil)
    }
    
    @objc func newNoteSaved() {
        let notificationManager: NotificationProtocol = LocalNotificationManager.shared
        notificationManager.sendNotification(title: "New Note!", message: "Your note is saved and listed.")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner, .badge, .list])
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Empty Fields", message: "Please fill all fields before saving", preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

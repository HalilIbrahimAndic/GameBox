//
//  NoteViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 19.01.2023.
//

import UIKit

class NoteViewController: UIViewController {
    
    
    @IBOutlet weak var noteTableView: UITableView!
    
    private let viewModel = NoteViewModel()
    private var tableHelper: NoteVCHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addNoteButtonPressed(_ sender: UIButton) {
    }
    
}

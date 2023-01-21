//
//  NoteCell.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDescription: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: NoteCellModel) {
        noteTitle.text = model.title
        noteDescription.text = model.note
        //noteDate.text = "\(model.date)"
    }
}



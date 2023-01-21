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

    func configure(with model: GameListCellModel) {
        contentImageView.kf.setImage(with: URL.init(string: model.background_image))
        gameNameLabel.text = model.name
        releasedValueLabel.text = model.released
        ratingLabel.text = "\(model.rating) / \(model.rating_top)"
    }
}



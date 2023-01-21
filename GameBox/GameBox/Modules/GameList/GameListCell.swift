//
//  GameListCell.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 16.01.2023.
//

import UIKit
import Kingfisher

class GameListCell: UITableViewCell {

    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var releasedValueLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //setupUI()
    }
    
    func configure(with model: GameListCellModel) {
        contentImageView.kf.setImage(with: URL.init(string: model.background_image))
        gameNameLabel.text = model.name
        releasedValueLabel.text = model.released
        ratingLabel.text = "\(model.rating) / \(model.rating_top)"
    }
}

//private extension GameListCell {
//
//    private func setupUI() {
//
//    }
//}
//
//  GameListCell.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 16.01.2023.
//

import UIKit
import Kingfisher
import Cosmos

class GameListCell: UITableViewCell {

    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var releasedValueLabel: UILabel!
    @IBOutlet weak var releasedText: UILabel!
    @IBOutlet weak var ratingText: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: GameListCellModel) {
        contentImageView.kf.setImage(with: URL.init(string: model.background_image))
        gameNameLabel.text = model.name
        releasedValueLabel.text = model.released
        releasedText.text = "Released".localized()
        
        cosmosView.rating = model.rating
        cosmosView.text = "\(model.rating)"
        
    }
}

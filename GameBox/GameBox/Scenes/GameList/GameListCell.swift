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
    @IBOutlet private weak var releasedTitleLabel: UILabel!
    @IBOutlet private weak var releasedValueLabel: UILabel!
    @IBOutlet private weak var genreTitleLabel: UILabel!
    @IBOutlet private weak var genreValueLabel: UILabel!
    @IBOutlet private weak var platformTitleLabel: UILabel!
    @IBOutlet private weak var platformValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func configure(with model: GameListCellModel) {
        contentImageView.kf.setImage(with: URL.init(string: model.background_image))
        gameNameLabel.text = model.name
        releasedValueLabel.text = model.released
    }
}

private extension GameListCell {
    
    private func setupUI() {
        releasedTitleLabel.text = "Released:"
//        genreTitleLabel.text = "Genre:"
//        platformTitleLabel.text = "Platforms:"
    }
}

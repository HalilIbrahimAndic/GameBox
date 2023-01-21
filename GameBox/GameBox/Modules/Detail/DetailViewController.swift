//
//  DetailViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 18.01.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    private var viewModel = DetailViewModel()
    private var items = DetailPageModel(id: 0, name: "", background_image: "", rating: 0.0, playtime: 0, reviews_count: 0, platforms: [], genres: [], tags: [], description_raw: "")
    private var cacheItems = DetailCacheModel(id: 0, name: "", background_image: "", rating: 0.0, playtime: 0, reviews_count: 0, platform_name: "", genre_name: "", tag_name: "", description_raw: "")
    
    var gameID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        viewModel.didViewLoad(gameID)
    }
    
    func setItems(_ items: DetailPageModel){
        self.items = items
        setupUI()
    }
    
    func setCacheItems(_ cacheItems: DetailCacheModel){
        //print(cacheItems) //array veriyo
        self.cacheItems = cacheItems
        //setupUI()
    }
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
//        favButton.isSelected.toggle()
//
//        favButton.title = "Title of the UIButton"
//        favButton.image = UIImage(systemName: "heart.filled",
//                                           withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        
        sender.isSelected = !sender.isSelected //By default sender.isSelected is false
                if sender.isSelected {
                    viewModel.didFavPressed(gameID)
                    //sender.setTitle("Favorited", for: .selected)
                    sender.setImage(UIImage(systemName: "heart.fill"), for: .selected)
                } else {
                    sender.setTitle("Favorite", for: .normal)
                    sender.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
    }

//MARK: - Extension
private extension DetailViewController {
    
    func setupUI() {
        self.title = items.name
        
        gameImage.kf.setImage(with: URL.init(string: items.background_image ))
        gameNameLabel.text = items.name
        timeLabel.text = String(items.playtime)
        commentLabel.text = String(items.reviews_count)
        ratingLabel.text = String(items.rating)
        descriptionLabel.text = items.description_raw
        
        let genreString = items.genres.map{$0.name}.joined(separator: ", ")
        let tagString = items.tags.map{$0.name}.joined(separator: ", ")
        let platformString = items.platforms.map{($0.platform.name)}.joined(separator: ", ")
        
        if InternetManager.shared.isInternetActive() {
            genreLabel.text = genreString
            tagLabel.text = tagString
            platformLabel.text = platformString
        } else {
            genreLabel.text = cacheItems.genre_name
            tagLabel.text = cacheItems.tag_name
            platformLabel.text = cacheItems.platform_name
        }
    }
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
        
        if InternetManager.shared.isInternetActive() {
            viewModel.refreshItems = { [weak self] items in
                self?.setItems(items)
            }
        } else {
//            viewModel.refreshCacheItems = { [weak self] items2 in
//                //self?.setCacheItems(items2)
//                print(items2)
//            }
        }
    }
}

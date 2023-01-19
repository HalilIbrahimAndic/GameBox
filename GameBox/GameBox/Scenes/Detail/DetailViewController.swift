//
//  DetailViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 18.01.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    
    private var viewModel = DetailViewModel()
    private var items = DetailPageModel(id: 0, name: "", description: "", metacritic: 0, released: "", backgroundImage: "", rating: 0.0, ratingTop: 0, playtime: 0, ratingsCount: 0, genres: [])
    var gameID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupUI()
        setupBinding()
        viewModel.didViewLoad(gameID)
    }
    
    func setItems(_ items: DetailPageModel){
        self.items = items
        setupUI()
    }
}

//MARK: - Extension
private extension DetailViewController {
    
    func setupUI() {
        
        let description = items.description ?? "a"
        let str = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        gameDescription.text = str
        gameTitle.text = items.name
        gameImage.kf.setImage(with: URL.init(string: items.backgroundImage ?? ""))
    }
    
    func setupBinding() {
        viewModel.onErrorOccured = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
        
        viewModel.refreshItems = { [weak self] items in
            self?.setItems(items)
        }
    }
}

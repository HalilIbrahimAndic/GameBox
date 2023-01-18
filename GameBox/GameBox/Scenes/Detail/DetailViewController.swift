//
//  DetailViewController.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 18.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    typealias RowItem = DetailPageModel
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    
    private var viewModel = DetailViewModel()
    private var items: [RowItem] = []
    var gameID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        viewModel.didViewLoad()
        gameTitle.text = "\(gameID)"
    }
    
    func setItems(_ items: [RowItem]){
        self.items = items
        print(items)
    }
}

//MARK: - Extension
private extension DetailViewController {
    
    func setupUI() {
        // TODO:
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

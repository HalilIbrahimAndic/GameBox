//
//  NoteDetailVCHelper.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit

class NoteDetailVCHelper: NSObject {
    
    typealias RowItem = NoteDetailPageModel
    
    weak var pickerView: UIPickerView?
    weak var viewModel: NoteDetailViewModel?
    weak var searchBar: UISearchBar?
    
    private var items: [RowItem] = []
    private var filteredItems: [RowItem] = []
    private var gameID = 0
    private var gameName = ""
    
    init(pickerView: UIPickerView, viewModel: NoteDetailViewModel, searchBar: UISearchBar) {
        self.pickerView = pickerView
        self.viewModel = viewModel
        self.searchBar = searchBar
        
        super.init()
        setupPickerView()
    }
    
    private func setupPickerView() {
        pickerView?.delegate = self
        pickerView?.dataSource = self
        searchBar?.delegate = self
    }
    
    func setItems(_ items: [RowItem]) {
        self.items = items
        filteredItems = items
        pickerView?.reloadAllComponents()
    }
}

extension NoteDetailVCHelper: UIPickerViewAccessibilityDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameID = filteredItems[row].id
        gameName = filteredItems[row].name
    }
}

extension NoteDetailVCHelper: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        filteredItems.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return filteredItems[row].name
    }
    
}

extension NoteDetailVCHelper: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredItems = []
        } else {
            filteredItems = items.filter{ ($0.name).localizedCaseInsensitiveContains(searchText) }
        }
        
        pickerView?.reloadAllComponents()
    }
}

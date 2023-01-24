//
//  NoteVCHelper.swift
//  GameBox
//
//  Created by Halil Ibrahim Andic on 22.01.2023.
//

import UIKit

/*
 Used protocol design pattern (learned in HW#1) to send the data of Notes.
 I wrote an article about this homework topic in medium.com. You can reach from here:
 https://medium.com/@hiandic/a-brief-example-to-delegate-design-pattern-invigilator-162f455daab4
*/
protocol canGoNote: AnyObject {
    func goToNoteDetail(_ noteData: NoteCellModel)
}

class NoteVCHelper: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    typealias RowItem = NoteCellModel
    private let cellIdentifier = "NoteCell"
    
    weak var delegate: canGoNote?
    weak var tableView: UITableView?
    weak var viewModel: NoteViewModel?
    weak var navigationController: UINavigationController?
    
    private var items: [RowItem] = []
    
    init(tableView: UITableView, viewModel: NoteViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
        
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView?.register(.init(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
    }
    
    func setItems(_ items: [RowItem]) {
        self.items = items
        tableView?.reloadData()
        tableView?.separatorStyle = .singleLine
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = items[indexPath.row]
        let noteData = NoteCellModel(name: index.name, note: index.note, date: index.date)
        
        // transfer data with protocol pattern
        delegate?.goToNoteDetail(noteData)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NoteCell
        cell.configure(with: items[indexPath.row])
        
        return cell
    }
    
    // Swipe Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete".localized()) { [self] (contextualAction, view, boolValue) in
            viewModel?.deleteNote(items[indexPath.row].name)
        }
        
        deleteAction.image = UIImage(systemName: "book.fill")
        deleteAction.backgroundColor = .red
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
}

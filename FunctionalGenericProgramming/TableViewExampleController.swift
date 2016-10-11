//
//  TableViewExampleController.swift
//  FunctionalGenericProgramming
//
//  Created by Luca D'Alberti on 9/30/16.
//  Copyright © 2016 STRV. All rights reserved.
//

import UIKit

final class TableViewExampleController: UIViewController {
    
    // MARK: - Private outlets
    @IBOutlet fileprivate weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    fileprivate lazy var _refreshControl: UIRefreshControl = self._makeRefreshControl()
    
    // MARK: - Private properties
    fileprivate var _dataSource: [Todo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
}

// MARK: - Actions
private extension TableViewExampleController {
    @objc func _refreshControlTriggered(sender: UIRefreshControl) {
        // reload the data
    }
}

// MARK: - UITableViewDataSource
extension TableViewExampleController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YOUR_IDENTIFIER")!
        
        // setup the cell
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewExampleController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // row selection logic
    }
}

// MARK: - Builders
private extension TableViewExampleController {
    
    func _makeRefreshControl() -> UIRefreshControl {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TableViewExampleController._refreshControlTriggered(sender:)), for: .valueChanged)
        
        self.tableView.addSubview(refreshControl)
        
        return refreshControl
    }
}

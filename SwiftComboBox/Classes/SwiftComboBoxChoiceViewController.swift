//
//  SwiftComboBox.swift
//  SwiftComboBox
//
//  Created by Yigit Serin on 14.01.2019.
//  Copyright © 2019 Yigit Serin. All rights reserved.
//

import UIKit

public struct SwiftComboBoxData{
    public var id: Int
    public var text: String
}

class SwiftComboBoxChoiceViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    
    @IBAction func searchBarButtonItemTapped(_ sender: Any) {
        
        if searchBarHeight.constant == 0{
            searchBarHeight.constant = 56
        }else{
            searchBarHeight.constant = 0
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func doneBarButtonItemTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // hides the keyboard.
    }
    
    var swiftComboBox: SwiftComboBox?
    
    public var originalDataSource: [SwiftComboBoxData] = []{
        didSet{
            filteredDataSource = originalDataSource
            
            if originalDataSource.count > 0 {
                swiftComboBox?.selectedItem = originalDataSource[0]
            }
        }
    }
    public var filteredDataSource: [SwiftComboBoxData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearchBar()
    }
}

extension SwiftComboBoxChoiceViewController: UITableViewDataSource, UITableViewDelegate{
    
    private func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: "SwiftComboBoxTableViewCell", bundle: Bundle(for: SwiftComboBoxChoiceViewController.self)), forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwiftComboBoxTableViewCell
        let item = filteredDataSource[indexPath.row]
        cell.label.text = item.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredDataSource[indexPath.row]
        swiftComboBox?.selectedItem = item
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SwiftComboBoxChoiceViewController: UISearchBarDelegate{
    
    private func initSearchBar(){
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lowercasedSearchText = searchText.lowercased()
        
        filteredDataSource = originalDataSource.filter({ (data) -> Bool in
            let lowercasedFilterText = data.text.lowercased()
            return lowercasedFilterText.contains(lowercasedSearchText)
        })
        
        if searchText == ""{
            filteredDataSource = originalDataSource
        }
        
        tableView.reloadData()
    }
}

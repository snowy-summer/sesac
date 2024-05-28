//
//  RestaurantTableViewController.swift
//  Travel
//
//  Created by 최승범 on 5/24/24.
//

import UIKit

final class RestaurantTableViewController: UITableViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    private let originalList = RestaurantList().restaurantArray
    private var restaurantList = RestaurantList().restaurantArray

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = tableView.frame.height / 5
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
       search()
    }
    
    @IBAction func searchingText(_ sender: UITextField) {
        
        search()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        tableView.endEditing(true)
    }
    
    private func search() {
        
        guard let text = searchTextField.text else { return }
        
        restaurantList = originalList.filter { $0.name.contains(text) || $0.category.contains(text) }
        
        if restaurantList.isEmpty {
            restaurantList = originalList
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - tableView
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier,
                                                       for: indexPath) as? RestaurantTableViewCell else {
            return RestaurantTableViewCell()
        }
       
        cell.configureContent(data: restaurantList[indexPath.row])
        
        return cell
    }

}


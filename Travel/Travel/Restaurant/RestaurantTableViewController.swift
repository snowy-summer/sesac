//
//  RestaurantTableViewController.swift
//  Travel
//
//  Created by 최승범 on 5/24/24.
//

import UIKit

final class RestaurantTableViewController: UITableViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    private let originalList = RestaurantList.restaurantArray
    private var filteredList = RestaurantList.restaurantArray

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = tableView.frame.height / 5
        configureNavigationBar()
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
        
        filteredList = originalList.filter { $0.name.contains(text) || $0.category.contains(text) }
        
        if filteredList.isEmpty {
            filteredList = originalList
        }
        
        tableView.reloadData()
        
    }
    
    @objc private func pushMapView() {
        
        guard let mapViewController = storyboard?.instantiateViewController(identifier: MapViewController.identifier) as? MapViewController else { return }
        
        navigationController?.pushViewController(mapViewController,
                                                 animated: true)
    }
    
    //MARK: - tableView
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier,
                                                       for: indexPath) as? RestaurantTableViewCell else {
            return RestaurantTableViewCell()
        }
       
        cell.configureContent(data: filteredList[indexPath.row])
        
        return cell
    }

}

// MARK: - configuration

extension RestaurantTableViewController {
    
    private func configureNavigationBar() {
        let mapViewButton = UIBarButtonItem(image: UIImage(systemName: "map"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(pushMapView))
        
        navigationItem.rightBarButtonItem = mapViewButton
    }
}

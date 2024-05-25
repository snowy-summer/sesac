//
//  RestaurantTableViewController.swift
//  Travel
//
//  Created by 최승범 on 5/24/24.
//

import UIKit

final class RestaurantTableViewController: UITableViewController {
    
    private let restaurantList = RestaurantList()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = tableView.frame.height / 5
    }

    
    
    //MARK: - tableView
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return restaurantList.restaurantArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell",
                                                       for: indexPath) as? RestaurantTableViewCell else {
            return RestaurantTableViewCell()
        }
        
        let data = restaurantList.restaurantArray[indexPath.row]
        let imageURL = URL(string: data.image)
        
        cell.restaurantImageView.kf.setImage(with: imageURL)
        cell.nameLabel.text = "이름: " + data.name
        cell.phoneNumberLabel.text = "번호: " + data.phoneNumber
        cell.priceLabel.text = "가격: \(data.price)"
        cell.addressLabel.text = "주소: " + data.address
        cell.menuLabel.text = "종류: " + data.category
        
        return cell
    }

}


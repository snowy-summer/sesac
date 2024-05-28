//
//  RestaurantTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 5/25/24.
//

import UIKit

final class RestaurantTableViewCell: UITableViewCell {

    static let identifier = "RestaurantTableViewCell"
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        restaurantImageView.layer.cornerRadius = 12
    }

    func configureContent(data: Restaurant) {
        
        let imageURL = URL(string: data.image)
        
        restaurantImageView.kf.setImage(with: imageURL)
        nameLabel.text = "이름: " + data.name
        phoneNumberLabel.text = "번호: " + data.phoneNumber
        priceLabel.text = "가격: \(data.price.formatted())"
        addressLabel.text = "주소: " + data.address
        menuLabel.text = "종류: " + data.category
    }
}

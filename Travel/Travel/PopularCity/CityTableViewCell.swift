//
//  CityTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 5/29/24.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
    
    static let identifier = "CityTableViewCell"

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    
    func configureLayout() {
        self.selectionStyle = .none
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        cityListLabel.font = .systemFont(ofSize: 12)
        cityListLabel.backgroundColor = .black.withAlphaComponent(0.3)
        cityListLabel.textColor = .white
        cityListLabel.layer.maskedCorners = [.layerMaxXMaxYCorner]
        cityListLabel.layer.cornerRadius = 12
        cityListLabel.layer.masksToBounds = true
        
        mainImageView.layer.maskedCorners = [.layerMinXMinYCorner,
                                             .layerMaxXMaxYCorner ]
        mainImageView.layer.cornerRadius = 12
    }
    
    func configureContent(data: City) {
        let url = URL(string: data.city_image)
        
        mainImageView.kf.setImage(with: url)
        titleLabel.text = data.titleName
        cityListLabel.text = data.city_explain
    }
}

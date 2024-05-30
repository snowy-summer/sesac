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
    
    
    private func configureLayout() {
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
    
    func highlightedLabel(searchText: String?) {
        attributeText(text: searchText, label: titleLabel)
        attributeText(text: searchText, label: cityListLabel)
        
    }
    
    private func attributeText(text: String?, label: UILabel) {
        
        guard let labelText = label.text,
              let text = text else { return }
        
        let attributedString = NSMutableAttributedString(string: labelText)
        
        if let range = labelText.range(of: text) {
            let nsRange = NSRange(range, in: labelText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: nsRange)
        }
        
        label.attributedText = attributedString
    }
}

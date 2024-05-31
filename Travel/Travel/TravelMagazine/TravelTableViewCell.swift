//
//  TravelTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 5/24/24.
//

import UIKit

final class TravelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainImageView.layer.cornerRadius = 12
        subtitleLabel.textColor = .darkGray
        dateLabel.textColor = .darkGray
    }
    
    func configureContent(data: Magazine) {
        
        let imageURL = URL(string: data.photoImage)
        
        mainImageView.kf.setImage(with: imageURL)
        
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        
        if let date = formatter.date(from: data.date) {
            formatter.dateFormat = "yy년 MM월 dd일"
            
            dateLabel.text = formatter.string(for: date)
        }
    }

}

//
//  TravelTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 5/24/24.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

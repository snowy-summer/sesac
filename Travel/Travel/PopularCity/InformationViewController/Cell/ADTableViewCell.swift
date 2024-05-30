//
//  ADTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 5/27/24.
//

import UIKit

class ADTableViewCell: UITableViewCell {
    
    static let identifier = "ADTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ADLogoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    override func prepareForReuse() {
        contentView.backgroundColor = UIColor.randomColor()
    }
    
    private func configureLayout() {
        self.selectionStyle = .none
        
        ADLogoLabel.layer.cornerRadius = 4
        ADLogoLabel.clipsToBounds = true
        ADLogoLabel.textAlignment = .center
    
        contentView.backgroundColor = UIColor.randomColor()
        contentView.layer.cornerRadius = 12
    }
    
    func configureData(data: Travel) {
        titleLabel.text = data.title
    }
    
    
    
}

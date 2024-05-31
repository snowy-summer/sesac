//
//  InformationTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 5/27/24.
//

import UIKit

final class InformationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureLayout()
    }
    
    override func prepareForReuse() {
        for index in 0..<5 {
            
           guard let imageView = starStackView.arrangedSubviews[index] as? UIImageView else { return }

            imageView.image = UIImage(systemName: "star")
            
        }
    }
    
    private func configureLayout() {
        self.selectionStyle = .none
        
        mainImageView.layer.cornerRadius = 8
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.font = .boldSystemFont(ofSize: 14)
        subtitleLabel.textColor = .lightGray
        
        likeButton.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
    
    func configureData(data: Travel) {
        titleLabel.text = data.title
        subtitleLabel.text = data.description
        
        if let urlString = data.travel_image {
            let url = URL(string: urlString)
            mainImageView.kf.setImage(with: url)
        }
        
        if let save = data.save {
            saveLabel.text = " 저장 \(save.formatted())"
        }
        
        if let like = data.like {
            let image = like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            likeButton.setImage(image,
                                for: .normal)
        }
        
        if let grade = data.grade {
            let convertedGrade = grade.rounded()
            
            for index in 0..<Int(convertedGrade) {
                
               guard let imageView = starStackView.arrangedSubviews[index] as? UIImageView else { return }

                imageView.image = UIImage(systemName: "star.fill")
                
            }
        }
    }
}

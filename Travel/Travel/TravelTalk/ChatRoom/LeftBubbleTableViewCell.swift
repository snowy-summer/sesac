//
//  LeftBubbleTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 6/1/24.
//

import UIKit

class LeftBubbleTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        configureDefault()
    }
}

extension LeftBubbleTableViewCell {
 
    private func configureDefault() {
        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.borderWidth = 0.5
        userImageView.layer.borderColor = UIColor.lightGray.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        
        bubbleView.layer.borderWidth = 1
        bubbleView.layer.cornerRadius = 8
    }
    
    func configureContent(data: Chat) {
        userImageView.image = UIImage(named: data.user.profileImage)
        userNameLabel.text = data.user.rawValue
        messageLabel.text = data.message
        timeStampLabel.text = data.date.timeFormatted()
        
    }
}

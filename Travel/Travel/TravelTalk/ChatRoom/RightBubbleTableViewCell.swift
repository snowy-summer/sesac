//
//  RightBubbleTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 6/1/24.
//

import UIKit

final class RightBubbleTableViewCell: UITableViewCell {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       configureDefault()
    }
    
}

extension RightBubbleTableViewCell {
 
    private func configureDefault() {
        bubbleView.layer.borderWidth = 1
        bubbleView.layer.cornerRadius = 8
        bubbleView.backgroundColor = .lightGray
    }
    
    func configureContent(data: Chat) {
        messageLabel.text = data.message
        timeStampLabel.text = data.date.timeFormatted()
        
    }
}

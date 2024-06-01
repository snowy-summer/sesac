//
//  ChatListTableViewCell.swift
//  Travel
//
//  Created by 최승범 on 6/1/24.
//

import UIKit

final class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var chatRoomImageView: UIImageView!
    @IBOutlet weak var chatRoomNameLabel: UILabel!
    @IBOutlet weak var recentMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDefault()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chatRoomImageView.layer.cornerRadius = chatRoomImageView.frame.width / 2
    }

}

extension ChatListTableViewCell {
    
    private func configureDefault() {
        chatRoomImageView.contentMode = .scaleAspectFill
        chatRoomImageView.layer.borderWidth = 0.5
        chatRoomImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        recentMessageLabel.textColor = .darkGray
        dateLabel.textColor = .lightGray
    }
    
    func configureContent(data: ChatRoom) {
        chatRoomNameLabel.text = data.chatroomName
        chatRoomImageView.image = UIImage(named: data.chatroomImage[0])
        
        if let chat = data.chatList.last {
            recentMessageLabel.text = chat.message
            dateLabel.text = chat.date.dateFormatted()
        } else {
            dateLabel.text = nil
            recentMessageLabel.text = nil
        }
    }
}

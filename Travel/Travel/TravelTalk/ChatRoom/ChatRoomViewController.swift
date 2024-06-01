//
//  ChatRoomViewController.swift
//  Travel
//
//  Created by 최승범 on 6/1/24.
//

import UIKit

final class ChatRoomViewController: UIViewController {
    
    @IBOutlet weak var chatRoomTableView: UITableView!
    @IBOutlet weak var chatInputView: UIView!
    @IBOutlet weak var chatTextView: UITextView!
    
    var chatList = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureChatInputView()
        scrollDown()
        configureChatTextView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        if chatTextView.text.isEmpty { return }
        
        chatList.append(Chat(user: .user,
                             date: Date.now.formatted(), message: chatTextView.text))
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        scrollDown()
    }
    
}

//MARK: - TableViewDelegate, DataSource

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let leftCell = tableView.dequeueReusableCell(withIdentifier: LeftBubbleTableViewCell.identifier) as? LeftBubbleTableViewCell else { return LeftBubbleTableViewCell() }
        guard let rightCell = tableView.dequeueReusableCell(withIdentifier: RightBubbleTableViewCell.identifier) as? RightBubbleTableViewCell else { return RightBubbleTableViewCell() }
        
        let data = chatList[indexPath.row]
        
        leftCell.configureContent(data: data)
        
        if data.user == .user {
            rightCell.configureContent(data: data)
            return rightCell
        }
        
        return leftCell
    }
    
}

//MARK: - textViewDelegate

extension ChatRoomViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        guard textView.contentSize.height < view.frame.width * 0.2 else {
            textView.isScrollEnabled = true
            return
        }
        
        textView.isScrollEnabled = false
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = textView.estimatedSizeHeight
                view.layoutIfNeeded()
            }
        }
        scrollDown()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor != UIColor.black {
            textView.text = nil
            textView.textColor = .black
        }
    
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메시지를 입력해주세요"
            textView.textColor = .lightGray
        }
        
        view.endEditing(true)
    }
}

// MARK: - configuration

extension ChatRoomViewController {
    
    private func configureTableView() {
        
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        chatRoomTableView.rowHeight = UITableView.automaticDimension
        chatRoomTableView.separatorStyle = .none
        
        let leftXib = UINib(nibName: LeftBubbleTableViewCell.identifier,
                            bundle: nil)
        let rightXib = UINib(nibName: RightBubbleTableViewCell.identifier,
                             bundle: nil)
        
        chatRoomTableView.register(leftXib,
                                   forCellReuseIdentifier: LeftBubbleTableViewCell.identifier)
        chatRoomTableView.register(rightXib,
                                   forCellReuseIdentifier: RightBubbleTableViewCell.identifier)
        
    }
    
    private func configureChatInputView() {
        chatInputView.layer.cornerRadius = 8
        chatInputView.backgroundColor = #colorLiteral(red: 0.8527900577, green: 0.8527900577, blue: 0.8527900577, alpha: 1)
        
    }
    
    private func configureChatTextView() {
        chatTextView.delegate = self
        chatTextView.isScrollEnabled = false
        chatTextView.heightAnchor.constraint(equalToConstant: chatTextView.estimatedSizeHeight).isActive = true
        
        chatTextView.text = "메시지를 입력해주세요"
        chatTextView.textColor = .lightGray
        chatTextView.font = .systemFont(ofSize: 14)
        chatTextView.backgroundColor = #colorLiteral(red: 0.8527900577, green: 0.8527900577, blue: 0.8527900577, alpha: 1)
    }
    
    private func scrollDown() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let indexPath = IndexPath(row: chatList.count - 1, section: 0)
            chatRoomTableView.scrollToRow(at: indexPath,
                                          at: .bottom,
                                          animated: false)
        }
    }
    
}


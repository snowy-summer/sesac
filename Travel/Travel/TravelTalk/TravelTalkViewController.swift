//
//  TravelTalkViewController.swift
//  Travel
//
//  Created by 최승범 on 6/1/24.
//

import UIKit

final class TravelTalkViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var travelTalkTableView: UITableView!
    
    private var chatList = mockChatList
    private var searchedChatList = [ChatRoom]()
    
    override func viewDidLoad() {
        configureNavigationBar()
        configureTableView()
        configureSearchController()
    
    }
}

extension TravelTalkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier) as? ChatListTableViewCell else { return ChatListTableViewCell() }
        
        let data = chatList[indexPath.row]
        
        cell.configureContent(data: data)
        
        return cell
    }
    
    
}

//MARK: - SearchController

extension TravelTalkViewController: UISearchResultsUpdating {
    private func searchLogic(text: String?) {
        
        guard var text = text else { return }
        
        text = text.lowercased()
        text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        searchedChatList = mockChatList.filter { $0.chatroomName.lowercased().contains(text) }
        
        chatList = searchedChatList.isEmpty ? mockChatList : searchedChatList
        
        travelTalkTableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchLogic(text: searchController.searchBar.text)
    }
    
    
    
}

// MARK: - configuration

extension TravelTalkViewController {
    
    private func configureNavigationBar() {
        navigationItem.title = "Travel Talk"
        navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        
        travelTalkTableView.delegate = self
        travelTalkTableView.dataSource = self
        travelTalkTableView.rowHeight = view.frame.height * 0.08
        travelTalkTableView.separatorStyle = .none
        
        let xib = UINib(nibName: ChatListTableViewCell.identifier,
                       bundle: nil)
    
        travelTalkTableView.register(xib,
                                     forCellReuseIdentifier: ChatListTableViewCell.identifier)
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "친구의 이름을 검색해보세요"
    }
}

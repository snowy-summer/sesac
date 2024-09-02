//
//  TravelTalkViewController.swift
//  Travel
//
//  Created by 최승범 on 6/1/24.
//

import UIKit
import SnapKit

final class TravelTalkViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var travelTalkTableView: UITableView!
    private var chatRoomList = mockChatList
    private var searchedChatRoomList = [ChatRoom]()
    
    override func viewDidLoad() {
        configureNavigationBar()
        configureTableView()
        configureSearchController()
    
    }
}

//MARK: - TableViewDelegate, DataSource

extension TravelTalkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return chatRoomList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier) as? ChatListTableViewCell else { return ChatListTableViewCell() }
        
        let data = chatRoomList[indexPath.row]
        
        cell.configureContent(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        guard let viewController = storyboard?.instantiateViewController(identifier: ChatRoomViewController.identifier) as? ChatRoomViewController else { return }
        
        viewController.navigationItem.title = chatRoomList[indexPath.row].chatroomName
        viewController.chatList = chatRoomList[indexPath.row].chatList
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

//MARK: - SearchController

extension TravelTalkViewController: UISearchResultsUpdating {
    private func searchLogic(text: String?) {
        
        guard var text = text else { return }
        
        text = text.lowercased()
        text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        searchedChatRoomList = mockChatList.filter { $0.chatroomName.lowercased().contains(text) }
        
        chatRoomList = searchedChatRoomList.isEmpty ? mockChatList : searchedChatRoomList
        
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


final class TravelTalkViewControllerUseCollectionView: UIViewController {
    
    enum Section: CaseIterable {
        case roomList
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: createLayout())
    var dataSource: UICollectionViewDiffableDataSource<Section, ChatRoom>!
    private var chatRoomList = mockChatList
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        configureDataSource()
        updateSnaphot()
    
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func configureDataSource() {
        
        var registeration: UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>
        
        registeration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.chatroomName
            content.image = UIImage(named: itemIdentifier.chatroomImage[0])
            content.imageProperties.maximumSize = CGSize(width: 40, height: 40)
            content.imageProperties.cornerRadius = content.image!.size.width / 2
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registeration,
                                                                    for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    
    private func updateSnaphot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,ChatRoom>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(chatRoomList, toSection: .roomList)
        dataSource.apply(snapshot)
    }
    
}

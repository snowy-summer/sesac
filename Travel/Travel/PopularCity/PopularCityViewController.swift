//
//  PopularCityViewController.swift
//  Travel
//
//  Created by 최승범 on 5/28/24.
//

import UIKit

class PopularCityViewController: UIViewController {
    
    @IBOutlet weak var CityTableView: UITableView!
//    @IBOutlet weak var citySearchBar: UISearchBar!
    
    private var list = CityInfo.city
    private var filteredList = CityInfo.city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureTableView()
    }
    
    private func showAllList() {
        filteredList = CityInfo.city
        list = filteredList
        CityTableView.reloadData()
    }
    
    private func selectCategory(isDomestic: Bool) {
        filteredList = CityInfo.city.filter { $0.domestic_travel == isDomestic }
        list = filteredList
        CityTableView.reloadData()
    }
    
    @IBAction func pickOtherCategory(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            showAllList()
        case 1:
            selectCategory(isDomestic: true)
        case 2:
            selectCategory(isDomestic: false)
        default:
            showAllList()
            
        }
    }
}

//MARK: - tableView Delegate, DataSource

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier,
                                                       for: indexPath) as? CityTableViewCell else {
            return CityTableViewCell()
        }
        
        let data = list[indexPath.row]
        
        cell.configureContent(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "InfomationViewController") as? InfomationViewController else { return }
        
        navigationController?.pushViewController(vc,
                                                 animated: true)
        
    }
   
}

extension PopularCityViewController: UISearchResultsUpdating {
    private func searchLogic(text: String?) {
        
        guard var text = text else { return }
        
        text = text.lowercased()
        text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        list = filteredList.filter { $0.titleName.lowercased().contains(text) || $0.city_explain.lowercased().contains(text) ||
            $0.city_english_name.lowercased().contains(text)
        }
        
        if text.isEmpty {
            list = filteredList
        }
        
        CityTableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchLogic(text: searchController.searchBar.text)
    }
    
    
    
}

extension PopularCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchLogic(text: searchBar.text)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchLogic(text: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        list = filteredList
        CityTableView.reloadData()
    }
}
//MARK: - configuration

extension PopularCityViewController {
    
    private func configureTableView() {
        CityTableView.delegate = self
        CityTableView.dataSource = self
    
        CityTableView.separatorStyle = .none
        
        let xib = UINib(nibName: CityTableViewCell.identifier,
                        bundle: nil)
        
        CityTableView.register(xib,
                               forCellReuseIdentifier: CityTableViewCell.identifier )
        CityTableView.rowHeight = view.frame.height * 0.2
    }
    
//    private func configureSearchBar() {
//        citySearchBar.delegate = self
//    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

//
//  TravelTableViewController.swift
//  0524
//
//  Created by 최승범 on 5/24/24.
//

import UIKit
import Kingfisher

final class TravelTableViewController: UITableViewController {
    private let magzineInfo = MagazineInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = tableView.frame.height * 0.55
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return magzineInfo.magazine.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier,
                                                       for: indexPath) as? TravelTableViewCell else {
            return TravelTableViewCell()
        }
        
        let data = magzineInfo.magazine[indexPath.row]
        
        cell.configureContent(data: data)
        
        return cell
    }
}


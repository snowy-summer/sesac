//
//  TableViewController.swift
//  0523
//
//  Created by 최승범 on 5/23/24.
//

import UIKit

class TableViewController: UITableViewController {
    
    private let sectionHeader = [
        "전체 설정",
        "개인 설정",
        "기타"
    ]
    
    private let settingList = [
        ["공지사항", "실험실", "버전 정보"],
        [ "개인/보안", "알림", "채팅", "멀티프로필"],
        [ "고객센터/도움말"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionHeader.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingList[section].count
        
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = settingList[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        
       return sectionHeader[section]
    }
    
}

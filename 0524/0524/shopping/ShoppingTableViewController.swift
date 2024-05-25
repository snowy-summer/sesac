//
//  ShoppingTableViewController.swift
//  0524
//
//  Created by 최승범 on 5/23/24.
//

import UIKit

struct ShoppingList {
    var isDone: Bool
    var title: String
    var isLike: Bool
}

final class ShoppingTableViewController: UITableViewController {
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var addTextFiled: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    private var list: [ShoppingList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        headerView.layer.cornerRadius = 8
    }
    
    @IBAction func addList(_ sender: UIButton) {
        guard let text = addTextFiled.text, addTextFiled.text?.isEmpty == false else { return }
        
        addTextFiled.text = .none
        list.append(ShoppingList(isDone: false,
                                 title: text,
                                 isLike: false))
        tableView.reloadData()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        tableView.endEditing(true)
    }
    
    @objc private func likeButtonClicked(_ sender: UIButton) {
        
        list[sender.tag - 1000].isLike.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag - 1000,
                                            section: 0)],
                             with: .automatic)
    }
    
    @objc private func checkButtonClicked(_ sender: UIButton) {
        
        list[sender.tag].isDone.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag,
                                            section: 0)],
                             with: .automatic)
    }
    
    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell",
                                                       for: indexPath) as? ListTableViewCell else {
            return ListTableViewCell()
        }
        
        let data = list[indexPath.row]
        
        let checkImageName = data.isDone ? "checkmark.square.fill" : "checkmark.square"
        let checkImage = UIImage(systemName: checkImageName)
        
        let starImageName = data.isLike ? "star.fill" : "star"
        let starImage = UIImage(systemName: starImageName)
        
        cell.title.text = data.title
        
        cell.checkButton.setImage(checkImage,
                                  for: .normal)
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self,
                                   action: #selector(checkButtonClicked),
                                   for: .touchUpInside)
        
        cell.likeButton.setImage(starImage,
                                 for: .normal)
        cell.likeButton.tag = indexPath.row + 1000
        cell.likeButton.addTarget(self,
                                  action: #selector(likeButtonClicked),
                                  for: .touchUpInside)

        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.rowHeight
    }
    
}

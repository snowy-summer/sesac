//
//  InfomationViewController.swift
//  Travel
//
//  Created by 최승범 on 5/27/24.
//

import UIKit

final class InfomationViewController: UIViewController {
    
    @IBOutlet weak var informationTableView: UITableView!

    private var list = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        informationTableView.delegate = self
        informationTableView.dataSource = self
        configureTableView()
    }
    
    private func configureTableView() {
        
        
        let informationXib = UINib(nibName: InformationTableViewCell.identifier, bundle: nil)
        let AdXib = UINib(nibName: ADTableViewCell.identifier, bundle: nil)
        
        informationTableView.register(informationXib, forCellReuseIdentifier: InformationTableViewCell.identifier)
        
        informationTableView.register(AdXib, forCellReuseIdentifier: ADTableViewCell.identifier)
        
        informationTableView.rowHeight = view.frame.height * 0.2
    }
}

extension InfomationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return list[indexPath.row].ad ? 60 : tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list[indexPath.row]
        
        if data.ad {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ADTableViewCell.identifier) as?
                    ADTableViewCell else {
                return ADTableViewCell()
            }

            cell.configureData(data: data)
        
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.identifier) as?
                InformationTableViewCell else {
            return InformationTableViewCell()
        }
        
        cell.configureData(data: data)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let data =  list[indexPath.row]
        if data.ad {
            
           guard let adViewController = storyboard?.instantiateViewController(identifier: ADViewController.identifier) as? ADViewController else { return }
            
            adViewController.adDescription = data.title
            
            let navigationController = UINavigationController(rootViewController: adViewController)

            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
            
        } else {
            
            guard let cityViewController = storyboard?.instantiateViewController(identifier: CityViewController.identifier) as? CityViewController else { return }
            
            cityViewController.data = data
            
            navigationController?.pushViewController(cityViewController, animated: true)
            
        }
        
    }
}

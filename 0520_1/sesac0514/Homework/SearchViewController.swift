//
//  SearchViewController.swift
//  sesac0514
//
//  Created by 최승범 on 5/16/24.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBackView: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBackView.backgroundColor = .lightGray
        searchBackView.layer.cornerRadius = 8
        discriptionLabel.numberOfLines = 0
        discriptionLabel.textAlignment = .center
        searchTextField.backgroundColor = .lightGray
        searchIcon.backgroundColor = .lightGray
        
        
        firstButton.tintColor = .darkGray
        secondButton.tintColor = .darkGray
        thirdButton.tintColor = .darkGray
    }
    
    @IBAction func toBeReleasedAction(_ sender: UIButton) {
        discriptionLabel.text = "공개예정"
        firstButton.tintColor = .lightGray
        secondButton.tintColor = .darkGray
        thirdButton.tintColor = .darkGray
    }
    
    @IBAction func showHotListAction(_ sender: UIButton) {
        discriptionLabel.text = "짜잔"
        firstButton.tintColor = .darkGray
        secondButton.tintColor = .lightGray
        thirdButton.tintColor = .darkGray
    }
    @IBAction func showTopTenListAction(_ sender: UIButton) {
        discriptionLabel.text = "10"
        firstButton.tintColor = .darkGray
        secondButton.tintColor = .darkGray
        thirdButton.tintColor = .lightGray
    }
    
}

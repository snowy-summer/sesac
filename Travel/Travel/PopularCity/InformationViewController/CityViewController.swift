//
//  CityViewController.swift
//  Travel
//
//  Created by 최승범 on 5/29/24.
//

import UIKit

final class CityViewController: UIViewController {
    
    static let identifier = "CityViewController"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "도시"
        
        configureMainImageView()
        
        guard let data = data ,
              let imageString = data.travel_image else { return }
        
        let url = URL(string: imageString)
        descriptionLabel.text = data.description
        mainImageView.kf.setImage(with: url)
    }
    
    
    func configureMainImageView() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 20
    }

}

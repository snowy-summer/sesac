//
//  MainViewController.swift
//  sesac0514
//
//  Created by 최승범 on 5/16/24.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var saveListButton: UIButton!
    @IBOutlet weak var hotListLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var firstHotImageView: UIImageView!
    @IBOutlet weak var firstTopTenImage: UIImageView!
    @IBOutlet weak var firstNewSeriseLabel: UILabel!
    
    @IBOutlet weak var secondHotImageView: UIImageView!
    @IBOutlet weak var secondTopTenImage: UIImageView!
    @IBOutlet weak var secondNewSeriseLabel: UILabel!
    
    @IBOutlet weak var thirdHotImageView: UIImageView!
    @IBOutlet weak var thirdTopTenImage: UIImageView!
    @IBOutlet weak var thirdNewSeriseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureMainImage()
        configureButton(playButton,
                        title: "재생",
                        tintColor: .white,
                        image: UIImage(resource: .play))
        configureButton(saveListButton,
                        title: "내가 찜한 콘텐츠",
                        tintColor: .lightGray,
                        image: UIImage(systemName: "plus"))
        configureHotListLabel()
        configureHotImage()
        
        
        
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        mainImageView.image = Drama.allCases.randomElement()?.image
        firstHotImageView.image = Drama.allCases.randomElement()?.image
        secondHotImageView.image = Drama.allCases.randomElement()?.image
        thirdHotImageView.image = Drama.allCases.randomElement()?.image
        
        let movieListImages = [
            firstTopTenImage,
            secondTopTenImage,
            thirdTopTenImage
        ]
        
        let newSeriesLables = [
            firstNewSeriseLabel,
            secondNewSeriseLabel,
            thirdNewSeriseLabel
        ]
        
        for index in 0..<3 {
            let isTopTen = Bool.random()
            let isNew = Bool.random()
            
            if isTopTen {
                movieListImages[index]?.isHidden = true
                
            } else {
                movieListImages[index]?.isHidden = false
            }
            
            if isNew {
                newSeriesLables[index]?.isHidden = true
                
            } else {
                newSeriesLables[index]?.isHidden = false
            }
        }
       
    }
    
    private func configureMainImage() {
        mainImageView.image = UIImage(resource: .범죄도시3)
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 20
        
    }
    
    private func configureButton(_ button: UIButton,
                                 title: String,
                                 tintColor: UIColor,
                                 image: UIImage?) {
        button.setTitle(title,
                                for: .normal)
        button.setImage(image,
                                for: .normal)
        button.tintColor = tintColor
        button.configuration = .filled()
    }
    
    private func configureHotListLabel() {
        hotListLabel.text = "지금 뜨는 콘텐츠"
    }
    
    private func configureHotImage() {
        firstHotImageView.image = UIImage(resource: .서울의봄)
        borderCornerRadius(firstHotImageView)
        
        secondHotImageView.image = UIImage(resource: .오펜하이머)
        borderCornerRadius(secondHotImageView)
        
        thirdHotImageView.image = UIImage(resource: .더퍼스트슬램덩크)
        borderCornerRadius(thirdHotImageView)
        
        firstTopTenImage.isHidden = true
        secondTopTenImage.isHidden = true
        thirdTopTenImage.isHidden = true
        
        configureSeriesLabel(label: firstNewSeriseLabel,
                             radius: 4,
                             isHidden: true)
        configureSeriesLabel(label: secondNewSeriseLabel,
                             radius: 4,
                             isHidden: true)
        configureSeriesLabel(label: thirdNewSeriseLabel,
                             radius: 4,
                             isHidden: true)
    }
    
    private func borderCornerRadius(_ view: UIView) {
        view.layer.cornerRadius = 8
    }
    
    private func configureSeriesLabel(label: UILabel,
                                      radius: CGFloat,
                                      isHidden: Bool) {
        label.layer.cornerRadius = radius
        label.isHidden = isHidden
    }


}

enum Drama: String, CaseIterable {
    case basketball = "더퍼스트슬램덩크"
    case boom = "오펜하이머"
    case seoul = "서울의봄"
    case city = "범죄도시3"
    
    var image: UIImage {
        switch self {
        case .basketball:
            UIImage(resource: .더퍼스트슬램덩크)
        case .boom:
            UIImage(resource: .오펜하이머)
        case .seoul:
            UIImage(resource: .서울의봄)
        case .city:
            UIImage(resource: .범죄도시3)
        }
    }
}

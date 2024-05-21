//
//  SearchViewController.swift
//  sesac0517
//
//  Created by 최승범 on 5/18/24.
//

import UIKit

final class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultBackgruondImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var extraKeyword01: UIButton!
    @IBOutlet weak var extraKeyword02: UIButton!
    @IBOutlet weak var extraKeyword03: UIButton!
    @IBOutlet weak var extraKeyword04: UIButton!
    
    
    private let newWords = [
        "분좋카": "분위기 좋은 카페",
        "완내스": "완전 내 스타일",
        "그 잡채": "그 자체를 소리나는 대로 적은 것",
        "자강두천": "자존심 강한 두 천재의 대결",
        "너또다": "너 또라이라 다행이다",
        "점메추": "점심 메뉴 추천"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundImageView()
        configureResultLabel()
        configureSearchButton()
        
        configureButton(extraKeyword01)
        configureButton(extraKeyword02)
        configureButton(extraKeyword03)
        configureButton(extraKeyword04)
        
    }
    
    @IBAction func seachingWord(_ sender: UIView) {
        resultBackgruondImageView.image = UIImage(resource: .background)
        
        showMeanning()
        showKeyword()
        
    }
    
    @IBAction func keywordTapped(_ sender: UIButton) {
        searchTextField.text = sender.title(for: .normal)
        
        showMeanning()
        showKeyword()
        
    }
    
    private func showMeanning() {
        let newWordsMean = newWords[searchTextField.text?.lowercased() ?? ""]
        resultLabel.text = newWordsMean ?? "없는 단어입니다."
    }
    
    private func showKeyword() {
        let buttons = [
            extraKeyword01,
            extraKeyword02,
            extraKeyword03,
            extraKeyword04
        ]
        
        var names = Set<String?>()
        
        while names.count < 5 {
            let name = newWords.keys.randomElement()
            if name != searchTextField.text {
                names.insert(name)
            }
        }
        
        for button in buttons {
            button?.isHidden = true
        }
        
        if let randomNum = (0...3).randomElement() {
            
            for index in 0...randomNum {
                
                buttons[index]?.setTitle(names.popFirst()!,
                                         for: .normal)
                buttons[index]?.isHidden = false
            }
        }
    }
    
    private func configureButton(_ button: UIButton) {
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.tintColor = .black
        button.isHidden = true
    }
    
    private func configureBackgroundImageView() {
        resultBackgruondImageView.image = UIImage(resource: .wordLogo)
    }
    
    private func configureResultLabel() {
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.font = .systemFont(ofSize: 24)
    }
    
    private func configureSearchButton() {
        searchButton.setTitle("",
                              for: .normal)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"),
                              for: .normal)
        searchButton.tintColor = .white
        searchButton.backgroundColor = .black
    }
    
}

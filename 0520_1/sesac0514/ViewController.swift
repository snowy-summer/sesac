//
//  ViewController.swift
//  sesac0514
//
//  Created by 최승범 on 5/14/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstMovieImageView: UIImageView!
    
    @IBOutlet weak var secondMovieImageView: UIImageView!
    
    @IBOutlet weak var thirdMovieImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        circle(firstMovieImageView)
        circle(secondMovieImageView)
        circle(thirdMovieImageView)
       
    }
    
    func circle(_ view: UIImageView) {
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderWidth = 1.5
        view.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }

}


//
//  ViewController.swift
//  sesac0517
//
//  Created by 최승범 on 5/18/24.
//

import UIKit

final class SlimeViewController: UIViewController {

    private var slimeTagAndCount = [Int:Int]()
    private  let slimeName = [
        "가",
        "나",
        "다",
        "라",
        "마",
        "바",
        "사",
        "아",
        "자"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSlimeCount()
        
    }
    
    @IBAction func slimeTapped(_ sender: UIButton) {

        slimeTagAndCount[sender.tag]? += 1
        if let count = slimeTagAndCount[sender.tag],
           let label = view.viewWithTag(sender.tag + 10) as? UILabel {
            
            label.text = "\(slimeName[sender.tag - 1]) \(count)"
            
            UserDefaults.standard.setValue(count, forKey: slimeName[sender.tag - 1])
        }
        
    }
    
    @IBAction func resetCount(_ sender: UIButton) {
        for slimeTag in 1...9 {
            UserDefaults.standard.removeObject(forKey: slimeName[slimeTag - 1])
        }
        
        initSlimeCount()
    }
    
    private func initSlimeCount() {
        for slimeTag in 1...9 {
            let count = UserDefaults.standard.integer(forKey: slimeName[slimeTag - 1])
            slimeTagAndCount.updateValue(count,
                                         forKey: slimeTag)
            if let label = view.viewWithTag(slimeTag + 10) as? UILabel {
                label.text = "\(slimeName[slimeTag - 1]) \(count)"
            }
        }
    }
    
    
}


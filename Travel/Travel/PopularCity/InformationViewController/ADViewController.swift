//
//  ADViewController.swift
//  Travel
//
//  Created by 최승범 on 5/29/24.
//

import UIKit

final class ADViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNaviagationBar()
    }
    
    private func configureNaviagationBar() {
        navigationItem.title = "광고"
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                           style: .plain,
                                           target: self,
                                           action:  #selector(dismissAD))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func dismissAD() {
        dismiss(animated: true)
    }
}

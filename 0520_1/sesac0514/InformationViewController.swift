//
//  InformationViewController.swift
//  sesac0514
//
//  Created by 최승범 on 5/14/24.
//

import UIKit

final class InformationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwardTextField: UITextField!
    @IBOutlet weak var recommendCodeTextField: UITextField!

    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNormalTextField(emailTextField,
                           placeholder: "이메일")
        configureSecureTextField(passwardTextField,
                           placeholder: "비밀번호")
        configureNormalTextField(recommendCodeTextField,
                           placeholder: "추천코드")
        roundBorder(signUpButton)
    }
    @IBAction func signUp(_ sender: UIButton) {
       if emailTextField.text != nil &&
            passwardTextField.text != nil &&
            passwardTextField.text!.count >= 6 {
           
           print("성공")
           
       } else {
           print("실패")
       }
        
    }
    
    @IBAction func onlyNumInput(_ sender: UITextField) {
        if Int(sender.text!) == nil {
            sender.text = ""
        }
    }
    
    
    private func configureNormalTextField(_ view: UITextField,
                                    placeholder: String
    ) {
        view.backgroundColor = .lightGray
        view.placeholder = placeholder
    }
    
    private func configureSecureTextField(_ view: UITextField,
                                    placeholder: String
    ) {
        view.backgroundColor = .lightGray
        view.placeholder = placeholder
//        view.isSecureTextEntry = true
    }
    
    

    private func roundBorder(_ customView: UIView) {
        
            customView.layer.cornerRadius = 8
    }
}


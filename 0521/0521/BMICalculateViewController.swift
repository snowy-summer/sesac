//
//  BMICalculateViewController.swift
//  0521
//
//  Created by 최승범 on 5/21/24.
//

import UIKit

final class BMICalculateViewController: UIViewController {
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var warringLabel: UILabel!
    
    @IBOutlet weak var randomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField(nicknameTextField,
                           borderWidth: 1,
                           radius: 8,
                           keyboard: .default)
        configureTextField(heightTextField,
                           borderWidth: 1,
                           radius: 8,
                           keyboard: .decimalPad)
        configureTextField(weightTextField,
                           borderWidth: 1,
                           radius: 8,
                           keyboard: .decimalPad)
    
        configureResultButton(resultButton,
                        radius: 8)
        configureRandomButton()
        configureWarringLabel()
        
        
    }
    
    
    @IBAction func writeInformation(_ sender: UITextField) {
        
        guard let text = sender.text,
              let _ = Double(text) else {
            showWarringLabel(text: "숫자를 입력해주세요")
            return
        }
        
        warringLabel.isHidden = true
        
        
    }
    
    @IBAction func calculateRadomBMI(_ sender: UIButton) {
        
       
        guard  let height = (100...200).randomElement(),
               let weight = (30...200).randomElement() else {
            
            return
        }
        
        heightTextField.text = "\(height)"
        weightTextField.text = "\(weight)"
        warringLabel.isHidden = true
        showResult(resultButton)
    }
    
    @IBAction func showResult(_ sender: UIButton) {
        
        guard let heightText = heightTextField.text,
              let height = Double(heightText) else {
            showWarringLabel(text: "잘못된 입력입니다")
            return
        }
        
        guard let weightText = weightTextField.text,
              let weight = Double(weightText) else {
            showWarringLabel(text: "잘못된 입력입니다")
            return
        }
        
        let bmi = caculateBMI(height: height,
                              weight: weight)
        
        if let nickname = nicknameTextField.text {
            UserDefaults.standard.setValue(height, forKey: "\(nickname) 키")
            UserDefaults.standard.setValue(weight, forKey: "\(nickname) 몸무게")
        }
        showResultAlert(bmi: bmi)
    }
    
    @IBAction func LoadInformation(_ sender: UIButton) {
        guard let nickname = nicknameTextField.text else {
            
            return
        }
        let height = UserDefaults.standard.double(forKey: "\(nickname) 키")
        let weight = UserDefaults.standard.double(forKey: "\(nickname) 몸무게")
                   
        heightTextField.text = "\(height)"
        weightTextField.text = "\(weight)"
                                                  
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func caculateBMI(height: Double,
                             weight: Double) -> Double {
        
        let bmi = weight / ( height / 100 * height / 100)
        return bmi
    }
    
    private func showResultAlert(bmi: Double) {
        
        let bmiText = String(format:"%.2f",bmi)
        let resultAlert = UIAlertController(title: "결과",
                                            message: "당신의 BMI는 \(bmiText)이고, \(checkBMI(for: bmi)) 입니다.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인",
                                          style: .default)
        
        resultAlert.addAction(confirmAction)
        
        present(resultAlert,
                animated: true)
    }
    
    private func checkBMI(for value: Double) -> String {
        switch value {
        case 0.0..<18.5:
            return "저체중"
        case 18.5..<23.0:
            return "정상"
        case 23.0..<25.0:
            return "과체중"
        case 25.0...100.0:
            return "비만"
        default:
            return "비만"
        }
    }
    
    private func showWarringLabel(text: String) {
        warringLabel.text = text
        warringLabel.isHidden = false
    }
    
    private func configureTextField(_ field: UITextField,
                                    borderWidth: CGFloat,
                                    radius: CGFloat,
                                    keyboard: UIKeyboardType) {
        
        field.font = .systemFont(ofSize: 20)
        field.keyboardType = keyboard
        field.layer.borderWidth = borderWidth
        field.layer.cornerRadius = radius
    }
    
    private func configureResultButton(_ button: UIButton,
                                 radius: CGFloat) {
        
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = radius
    }
    
    private func configureRandomButton() {
        randomButton.setTitle("랜덤으로 bmi 계산하기", for: .normal)
        randomButton.tintColor = .red
        
    }
    
    private func configureWarringLabel() {
        warringLabel.textColor = .red
        warringLabel.isHidden = true
    }
    
}

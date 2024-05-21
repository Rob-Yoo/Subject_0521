//
//  ViewController.swift
//  BMICalculator
//
//  Created by Jinyoung Yoo on 5/21/24.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    
    @IBOutlet private var characterImageView: UIImageView!
    
    @IBOutlet private var heightAskingLabel: UILabel!
    @IBOutlet private var heightTextField: UITextField!
    
    @IBOutlet private var weightAskingView: UIView!
    @IBOutlet private var weightAskingLabel: UILabel!
    @IBOutlet private var blindButton: UIButton!
    @IBOutlet private var weightTextField: UITextField!
    @IBOutlet private var randomCalculateButton: UIButton!
    
    @IBOutlet private var resultButton: UIButton!

    private var height: Double = 0
    private var weight: Double = 0
    
    private var isValidateValue: Bool {
        if (self.weight < 1 ||
            self.weight > 635 ||
            self.height < 1 ||
            self.height > 251
        ) {
            return false
        }
        return true
    }
    
    private var isBlindButtonActivate = false {
        willSet {
            if (newValue) {
                self.blindWeight()
            } else {
                self.revealWeight()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cofigureTitleLabel()
        self.configureSubTitleLabel()
        self.configureCharacterImageView()
        self.configureAskingLabel()
        self.configureHeightTextField()
        self.configureWeightAskingView()
        self.configureWeightTextField()
        self.configureRandomCalculateButton()
        self.configureResultButton()
    }
    
    @IBAction func keboardDismiss() {
        self.view.endEditing(true)
    }
    
    // Event: Editing Changed
    @IBAction func heightTextFieldChanged(_ sender: UITextField) {
        guard let height = sender.text, !height.isEmpty else {
            self.height = 0
            return
        }
        
        if height.allSatisfy({ $0.isNumber }) {
            self.height = Double(height)!
        } else {
            self.showAlert(title: "알림", message: "비정상적인 값이 입력되었습니다.")
            self.heightTextField.text = ""
            self.height = 0
        }
    }
    
    // Event: Editing Changed
    @IBAction func weightTextFieldChanged(_ sender: UITextField) {
        guard let weight = sender.text, !weight.isEmpty else {
            self.weight = 0
            return
        }
        
        if weight.allSatisfy({ $0.isNumber }) {
            self.weight = Double(weight)!
        } else {
            self.showAlert(title: "알림", message: "비정상적인 값이 입력되었습니다.")
            self.weightTextField.text = ""
            self.weight = 0
        }
    }
    
    @IBAction func blindButtonTapped(_ sender: UIButton) {
        self.isBlindButtonActivate.toggle()
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        self.setRandomValue()
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        let hValue = self.heightTextField.text ?? ""
        let wValue = self.weightTextField.text ?? ""

        if (self.isValidateValue) {
            self.showResult()
        } else if (hValue.isEmpty) {
            self.showAlert(title: "알림", message: "키를 입력해주세요.")
        } else if (wValue.isEmpty) {
            self.showAlert(title: "알림", message: "몸무게를 입력해주세요.")
        } else {
            self.showAlert(title: "알림", message: "너무 크거나 작은 값이 입력되었습니다.\n다시 확인해주세요.")
        }
    }
}

//MARK: - Configure Subviews
extension BMICalculatorViewController {
    private func cofigureTitleLabel() {
        self.titleLabel.text = "BMI Calculator"
        self.titleLabel.textColor = .black
        self.titleLabel.textAlignment = .left
        self.titleLabel.font = .boldSystemFont(ofSize: 25)
    }
    
    private func configureSubTitleLabel() {
        self.subTitleLabel.text = "당신의 BMI 지수를\n알려드릴께요."
        self.subTitleLabel.textColor = .black
        self.subTitleLabel.textAlignment = .left
        self.subTitleLabel.numberOfLines = 0
        self.subTitleLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private func configureCharacterImageView() {
        self.characterImageView.image = .image
        self.characterImageView.contentMode = .scaleAspectFill
    }
    
    private func configureAskingLabel() {
        self.designAskingLabel(label: self.heightAskingLabel, text: "키가 어떻게 되시나요?")
        self.designAskingLabel(label: self.weightAskingLabel, text: "몸무게는 어떻게 되시나요?")
    }
    
    private func configureHeightTextField() {
        self.designTextField(textField: self.heightTextField)
        self.heightTextField.layer.cornerRadius = 15
        self.heightTextField.layer.borderWidth = 2
        self.heightTextField.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    private func configureWeightAskingView() {
        self.weightAskingView.layer.cornerRadius = 15
        self.weightAskingView.layer.borderWidth = 2
        self.weightAskingView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    private func configureWeightTextField() {
        self.blindButton.setTitle("", for: .normal)
        self.blindButton.setImage(.init(systemName: "eye.slash"), for: .normal)
        self.blindButton.tintColor = .lightGray
        
        self.designTextField(textField: self.weightTextField)
    }
    
    private func configureRandomCalculateButton() {
        self.randomCalculateButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        self.randomCalculateButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        self.randomCalculateButton.setTitleColor(.brown, for: .normal)
    }
    
    private func configureResultButton() {
        self.resultButton.setTitle("결과 확인", for: .normal)
        self.resultButton.setTitleColor(.white, for: .normal)
        self.resultButton.backgroundColor = .purple
        self.resultButton.layer.cornerRadius = 15
    }
}

//MARK: - Rendering Utility Methods
extension BMICalculatorViewController {
    private func designAskingLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
    }
    
    private func designTextField(textField: UITextField) {
        let emptyView = UIView(frame: .init(x: 0, y: 0, width: 30, height: 30))
        
        textField.leftView = emptyView
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.tintColor = .black
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}

//MARK: - Presentation Logic
extension BMICalculatorViewController {
    private func showResult() {
        let bmi = self.weight / pow((self.height / 100), 2)
        let stringBMI = String(format: "%.2f", bmi)
        
        self.showAlert(title: "BMI 지수 결과", message: stringBMI)
    }
    
    private func setRandomValue() {
        let wValue = Int.random(in: 40...100)
        let hValue = Int.random(in: 150...200)

        self.weight = Double(wValue)
        self.height = Double(hValue)
        self.heightTextField.text = String(wValue)
        self.weightTextField.text = String(hValue)
    }
    
    private func blindWeight() {
        self.blindButton.setImage(.init(systemName: "eye"), for: .normal)
        self.weightTextField.isSecureTextEntry = true
    }
    
    private func revealWeight() {
        self.blindButton.setImage(.init(systemName: "eye.slash"), for: .normal)
        self.weightTextField.isSecureTextEntry = false
    }

}

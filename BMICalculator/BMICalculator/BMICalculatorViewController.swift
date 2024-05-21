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
    
    @IBOutlet var weightAskingView: UIView!
    @IBOutlet private var weightAskingLabel: UILabel!
    @IBOutlet private var hideButton: UIButton!
    @IBOutlet private var weightTextField: UITextField!
    @IBOutlet private var randomCalculateButton: UIButton!
    
    @IBOutlet private var resultButton: UIButton!
    
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

}

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
        self.heightTextField.borderStyle = .none
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
        self.hideButton.setTitle("", for: .normal)
        self.hideButton.setImage(.init(systemName: "eye.slash"), for: .normal)
        self.hideButton.tintColor = .lightGray
        
        self.weightTextField.borderStyle = .none
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

extension BMICalculatorViewController {
    private func designAskingLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
    }
}

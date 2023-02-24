//
//  BaseAP.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/18.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
// Base Add Page

// MARK: 메모관련 추가페이지를 조금이라도 편하게 하고자 만든 페이지입니다.

import UIKit
import Then

class BaseAP: BaseVC {
    
    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray,
                      .font : UIFont.systemFont(ofSize: 14, weight: .bold)]
    
    
    internal lazy var firstView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10.0
    }
    
    
    internal lazy var secondView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10.0
    }
    
    internal lazy var firstTitle = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 10.0, weight: .semibold)
        $0.textColor = .white
        $0.text = "기존 정보"
    }
    
    internal lazy var secondTitle = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 10.0, weight: .semibold)
        $0.textColor = .white
        $0.text = "추가 정보"
    }
    
    internal lazy var firstTextField = UITextField().then {
        $0.borderStyle = UITextField.BorderStyle.none
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.leftViewMode = .always
        $0.textColor = .white
    }
    
    internal lazy var secondTextField = UITextField().then {
        $0.borderStyle = UITextField.BorderStyle.none
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.leftViewMode = .always
        $0.textColor = .white
    }
    
    internal lazy var relatedImage = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 18
    }
    
    internal lazy var iconChoiceButton = UIButton().then {
        $0.setTitle("아이콘 선택", for: .normal)
        $0.setTitleColor(UIColor(ciColor: .gray), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.choiceColor.cgColor
    }
    
    internal lazy var urlIconChoiceButton = UIButton().then {
        $0.setTitle("URL 아이콘 선택", for: .normal)
        $0.setTitleColor(UIColor(ciColor: .gray), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.choiceColor.cgColor
    }
    
    internal lazy var firstLine = UIView().then {
        $0.backgroundColor = .gray
    }
    internal lazy var secondLine = UIView().then {
        $0.backgroundColor = .gray
    }
    
    func updateWith(_ controller: UIViewController) {
        
        lazy var textFields = [firstTextField, secondTextField]
        let placeholders = ["firstTextField placeholders", "secondTestField placeholders"]
        
        var index = 0
        for textField in textFields {
            textField.attributedPlaceholder = NSAttributedString(string: placeholders[index],
                                                                 attributes: attributes)
            textField.delegate = self
            index += 1
        }
        
        [
            firstView,
            firstTitle,
            firstTextField,
            firstLine,
            secondTextField,
            secondLine,
            
            secondView,
            secondTitle,
            relatedImage,
            iconChoiceButton,
            urlIconChoiceButton
        ].forEach { view.addSubview($0) }
        
        let width = controller.view.frame.width / 430.0
        let height = controller.view.frame.height / 932.0
        
        firstView.snp.makeConstraints {
            $0.height.equalTo(20.0)
            $0.width.equalTo(60.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15.0)
            $0.leading.equalToSuperview().inset(25.0)
        }
        
        firstTitle.snp.makeConstraints {
            $0.centerX.equalTo(firstView.snp.centerX)
            $0.centerY.equalTo(firstView.snp.centerY)
        }
        
        firstTextField.snp.makeConstraints {
            $0.top.equalTo(firstTitle.snp.bottom).offset(35.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(382.0 * width)
            $0.height.equalTo(46.0 * height)
        }
        
        firstLine.snp.makeConstraints {
            $0.top.equalTo(firstTextField.snp.bottom)
            $0.leading.equalTo(firstTextField.snp.leading)
            $0.height.equalTo(2.0)
            $0.width.equalTo(382)
        }
        
        secondTextField.snp.makeConstraints {
            $0.top.equalTo(firstLine.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(firstTextField.snp.width)
            $0.height.equalTo(firstTextField.snp.height)
        }
        
        secondLine.snp.makeConstraints {
            $0.top.equalTo(secondTextField.snp.bottom)
            $0.leading.equalTo(secondTextField.snp.leading)
            $0.height.equalTo(2.0)
            $0.width.equalTo(382)
        }
        
        secondView.snp.makeConstraints {
            $0.height.equalTo(20.0)
            $0.width.equalTo(60.0)
            $0.top.equalTo(secondLine.snp.bottom).offset(100.0)
            $0.leading.equalToSuperview().inset(25.0)
        }
        
        secondTitle.snp.makeConstraints {
            $0.centerX.equalTo(secondView.snp.centerX)
            $0.centerY.equalTo(secondView.snp.centerY)
        }
        
        relatedImage.snp.makeConstraints {
            $0.top.equalTo(secondTitle.snp.bottom).offset(15.0)
            $0.centerX.equalTo(secondView.snp.centerX)
            $0.width.height.equalTo(36.0)
        }
        
        iconChoiceButton.snp.makeConstraints {
            $0.top.equalTo(relatedImage.snp.bottom).offset(15.0)
            $0.leading.equalToSuperview().offset(15.0)
            $0.height.equalTo(35.0)
            $0.width.equalTo(175.0)
        }
        
        urlIconChoiceButton.snp.makeConstraints {
            $0.top.equalTo(iconChoiceButton.snp.top)
            $0.trailing.equalToSuperview().inset(15.0)
            $0.height.equalTo(iconChoiceButton.snp.height)
            $0.width.equalTo(iconChoiceButton.snp.width)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        navigationRelated()
    }
    
    func navigationRelated() {
        view.backgroundColor = .black
        title = "title"
        
        let saveButton: UIBarButtonItem? = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        saveButton?.tintColor = .blue
        saveButton?.title = "저장"
        
        let exitButton: UIBarButtonItem? = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        exitButton?.tintColor = .blue
        exitButton?.title = "나가기"
        self.navigationItem.leftBarButtonItem = exitButton
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func animate(line: UIView) {
        line.alpha = 0.3
        UIView.animate(withDuration: 1) {
            line.alpha = 1
        }
    }
}


extension BaseAP: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case firstTextField: animate(line: firstLine)
        case secondTextField: animate(line: secondLine)
        default: return
        }
    }
}

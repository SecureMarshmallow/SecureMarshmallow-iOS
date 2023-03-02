//
//  AddPasswordViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/17.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit
import SnapKit
import Then

// MARK: 비밀번호 추가 페이지를 클릭하면 나오는 view 입니다.

class AddPasswordViewController: BaseAP {
    
    internal lazy var passwordTextField = UITextField().then {
        $0.borderStyle = UITextField.BorderStyle.none
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.leftViewMode = .always
        $0.textColor = .white
    }
    
    internal lazy var passwordLine = UIView().then {
        $0.backgroundColor = .gray
    }
    
    internal lazy var againPasswordTextField = UITextField().then {
        $0.borderStyle = UITextField.BorderStyle.none
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.leftViewMode = .always
        $0.textColor = .white
    }
    
    internal lazy var againPasswordLine = UIView().then {
        $0.backgroundColor = .gray
    }
    
    let placeholder = "메모를 입력해주세요."

    
    let activityTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 14)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.black
        $0.tintColor = UIColor.choiceColor
        $0.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    let letterNumLabel = UILabel().then {
        $0.text = "0/150"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = UIColor.gray
        $0.textAlignment = .right
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        configUI()
        setupTextView()
    }
    
    func configUI() {
        view.backgroundColor = .black
    }

    func setupTextView() {
        activityTextView.text = placeholder
        activityTextView.textColor = UIColor.gray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        
        title = "비밀번호"
        
        lazy var textFields = [firstTextField, secondTextField, passwordTextField, againPasswordTextField]
        let placeholders = ["제목", "아이디", "비밀번호", "비밀번호를 다시 입력해주세요."]
        
        var index = 0
        for textField in textFields {
            textField.attributedPlaceholder = NSAttributedString(string: placeholders[index],
                                                                 attributes: attributes)
            textField.delegate = self
            activityTextView.delegate = self
            index += 1
        }
        
        [
            passwordTextField,
            passwordLine,
            againPasswordTextField,
            againPasswordLine,
            activityTextView,
            letterNumLabel
        ].forEach { view.addSubview($0) }
        
        let width = controller.view.frame.width / 430.0
        let height = controller.view.frame.height / 932.0
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(secondLine.snp.bottom).offset(16.0)
            $0.width.equalTo(382.0 * width)
            $0.height.equalTo(46.0 * height)
            $0.centerX.equalToSuperview()
        }
        
        passwordLine.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.leading.equalTo(passwordTextField.snp.leading)
            $0.height.equalTo(2.0)
            $0.width.equalTo(382)
        }
        
        againPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLine.snp.bottom).offset(16.0)
            $0.width.equalTo(382.0 * width)
            $0.height.equalTo(46.0 * height)
            $0.centerX.equalToSuperview()
        }
        
        againPasswordLine.snp.makeConstraints {
            $0.top.equalTo(againPasswordTextField.snp.bottom)
            $0.leading.equalTo(againPasswordTextField.snp.leading)
            $0.height.equalTo(2.0)
            $0.width.equalTo(382)
        }
        
        activityTextView.snp.makeConstraints {
            $0.top.equalTo(againPasswordLine.snp.bottom).offset(55.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(372)
            $0.width.equalTo(382)
        }
        
        letterNumLabel.snp.makeConstraints {
            $0.top.equalTo(activityTextView.snp.bottom).offset(6)
            $0.trailing.equalToSuperview().inset(28)
        }
    }
}

extension AddPasswordViewController {
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case firstTextField: animate(line: firstLine)
        case secondTextField: animate(line: secondLine)
        case passwordTextField: animate(line: passwordLine)
        case againPasswordTextField: animate(line: againPasswordLine)
        default: return
        }
    }
}

extension AddPasswordViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        activityTextView.layer.borderWidth = 1
        activityTextView.layer.borderColor = UIColor.choiceColor.cgColor
        
        
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            activityTextView.textColor = UIColor.gray
            activityTextView.text = placeholder
        } else if textView.text == placeholder {
            activityTextView.textColor = UIColor.white
            activityTextView.text = nil
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if activityTextView.text.count > 150 {
            activityTextView.deleteBackward()
        }
        
        letterNumLabel.text = "\(activityTextView.text.count)/150"
        
        let attributedString = NSMutableAttributedString(string: "\(activityTextView.text.count)/150")
        attributedString.addAttribute(.foregroundColor, value: UIColor.choiceColor, range: ("\(activityTextView.text.count)/150" as NSString).range(of:"\(activityTextView.text.count)"))
        letterNumLabel.attributedText = attributedString
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        activityTextView.layer.borderWidth = 0
        
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            activityTextView.textColor = UIColor.gray
            activityTextView.text = placeholder
            letterNumLabel.textColor = UIColor.gray
            letterNumLabel.text = "0/150"
        }
    }
}







//    private lazy var characterButton = UIButton().then {
//        $0.setTitle("전으로", for: .normal)
//        $0.setTitleColor(UIColor(ciColor: .white), for: .normal)
//        $0.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
//        $0.backgroundColor = .white
//        $0.rx.tap
//            .bind {
//                self.dismiss(animated: true)
//                print("true")
//            }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        title = "아아아"
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .red
//
//        let saveButton: UIBarButtonItem? = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
//        saveButton?.tintColor = .blue
//        saveButton?.title = "저장"
//
//        let exitButton: UIBarButtonItem? = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(exitButtonDidTap))
//        exitButton?.tintColor = .blue
//        exitButton?.title = "나가기"
////        exitButton?.image = UIImage(named: "lessthan")
//
//        self.navigationItem.leftBarButtonItem = exitButton
//        self.navigationItem.rightBarButtonItem = saveButton
//
//        view.addSubview(characterButton)
//
//        characterButton.snp.makeConstraints {
//            $0.height.width.equalTo(200)
//            $0.centerY.centerX.equalToSuperview()
//        }
//    }
//
//    @objc
//    func exitButtonDidTap() {
//        self.dismiss(animated: true)
//    }

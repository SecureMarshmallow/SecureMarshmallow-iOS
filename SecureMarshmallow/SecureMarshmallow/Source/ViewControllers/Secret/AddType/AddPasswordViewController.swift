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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
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
            index += 1
        }
        
        [
            passwordTextField,
            passwordLine,
            againPasswordTextField,
            againPasswordLine
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

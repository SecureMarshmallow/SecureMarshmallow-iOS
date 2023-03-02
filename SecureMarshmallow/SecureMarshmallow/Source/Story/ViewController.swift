//
//  ViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/03/02.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit

import Then
import SnapKit

class ViewController: UIViewController {

    let placeholder = "(예 : 오늘 아침에 일어나서 중랑천 2.5km 뛰었음)"
    
    let activityTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 14)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.black
        $0.tintColor = UIColor.systemPink
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
        configUI()
        setupAutoLayout()
        setupTextView()
    }
    
    func configUI() {
        view.backgroundColor = .black
    }
    
    func setupAutoLayout() {
        view.addSubview(activityTextView)
        view.addSubview(letterNumLabel)
        
        activityTextView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(190)
            make.width.equalTo(319)
        }
        
        letterNumLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTextView.snp.bottom).offset(6)
            make.trailing.equalToSuperview().inset(28)
        }
    }
    
    func setupTextView() {
        activityTextView.delegate = self
        activityTextView.text = placeholder
        activityTextView.textColor = UIColor.gray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        activityTextView.layer.borderWidth = 1
        activityTextView.layer.borderColor = UIColor.systemPink.cgColor
        
        
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
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemPink, range: ("\(activityTextView.text.count)/150" as NSString).range(of:"\(activityTextView.text.count)"))
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

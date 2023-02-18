//
//  BaseAP.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/18.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
// Base Add Page

import UIKit
import Then

class BaseAP: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    override func layout() {
        super.layout()
        
        [
            firstView,
            firstTitle
        ].forEach { view.addSubview($0) }
        
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
    }
    
    var firstView = UIView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10.0
    }
    
    var firstTitle = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 10.0, weight: .semibold)
        $0.textColor = .white
        $0.text = "기존 정보"
    }
    
    
}

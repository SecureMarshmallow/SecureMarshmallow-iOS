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

class AddPasswordViewController: BaseVC {
    
    private lazy var characterButton = UIButton().then {
        $0.setTitle("전으로", for: .normal)
        $0.setTitleColor(UIColor(ciColor: .white), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.backgroundColor = .white
        $0.rx.tap
            .bind {
                self.dismiss(animated: true)
                print("true")
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(characterButton)
        
        characterButton.snp.makeConstraints {
            $0.height.width.equalTo(200)
            $0.centerY.centerX.equalToSuperview()
        }
    }
}

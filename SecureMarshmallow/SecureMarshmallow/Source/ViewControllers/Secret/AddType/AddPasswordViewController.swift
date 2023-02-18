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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        title = "아아아"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let saveButton: UIBarButtonItem? = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        saveButton?.tintColor = .blue
        saveButton?.title = "저장"
        
        let exitButton: UIBarButtonItem? = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(exitButtonDidTap))
        exitButton?.tintColor = .blue
        exitButton?.title = "나가기"
//        exitButton?.image = UIImage(named: "lessthan")
        
        self.navigationItem.leftBarButtonItem = exitButton
        self.navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(characterButton)
        
        characterButton.snp.makeConstraints {
            $0.height.width.equalTo(200)
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    @objc
    func exitButtonDidTap() {
        self.dismiss(animated: true)
    }
}

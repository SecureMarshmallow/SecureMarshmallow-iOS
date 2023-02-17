//
//  SecretCollectionViewCell.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/16.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit
import SnapKit

class SecretCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SecretCollectionViewCell"
    
    var secretBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10.0
    }
    
    var imageView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 15.0
    }
    
    var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 17.0, weight: .regular)
        $0.textColor = .black
        $0.text = "메모"
    }
    
    func layout() {
        self.addSubview(secretBackgroundView)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        secretBackgroundView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalTo(secretBackgroundView.snp.centerY)
            $0.leading.equalTo(secretBackgroundView.snp.leading).inset(20.0)
            $0.height.width.equalTo(30.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.leading.equalTo(imageView.snp.trailing).offset(10.0)
        }
    }
}

//
//  AddSecretCollectionViewCell.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/16.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit
import SnapKit
import Then

class AddSecretCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "AddSecretCollectionViewCell"
    
    var collectionBackground = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    var imageView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .blue
        $0.layer.borderColor = UIColor.gray.cgColor
    }
    
    private let label = UILabel().then {
        $0.font = .systemFont(ofSize: 20.0, weight: .regular)
        $0.textAlignment = .left
        $0.textColor = .white
    }
    
    public var text: String = "" {
        didSet {
            label.text = text.isEmpty ? " " : text
        }
    }
    
    func layout() {
        [
            collectionBackground,
            imageView,
            label
        ].forEach { contentView.addSubview($0) }
        
        collectionBackground.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(45.0)
            $0.width.equalTo(353.0)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalTo(collectionBackground.snp.leading).inset(40.0)
            $0.centerY.equalTo(collectionBackground.snp.centerY)
            $0.height.width.equalTo(35.0)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(20.0)
            $0.centerY.equalTo(collectionBackground.snp.centerY)
        }
    }
}

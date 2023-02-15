//
//  BlurCell.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/15.
//

import UIKit
import SnapKit
import Then

class BlurCell: UICollectionViewCell {
    
    static var identifier = "BlurCell"
    
    var imageView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 35
    }
    
    public var text: String = "" {
        didSet {
            label.text = text.isEmpty ? " " : text
        }
    }
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {

        contentView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blurEffectView)
        
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12.0, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        
        let g = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            // constrain blur view to all 4 sides of contentView
            blurEffectView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0.0),
            blurEffectView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0.0),
            blurEffectView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0.0),
            blurEffectView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0.0),
        ])
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(blurEffectView.snp.top).offset(30.0)
            $0.centerX.equalTo(blurEffectView.snp.centerX)
            $0.height.width.equalTo(70.0)
        }
        
        label.snp.makeConstraints {
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.top.equalTo(imageView.snp.bottom).offset(20.0)
        }
        
    }
}

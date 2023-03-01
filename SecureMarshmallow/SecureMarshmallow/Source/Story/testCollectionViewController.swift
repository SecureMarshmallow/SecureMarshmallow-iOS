//
//  testCollectionViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/25.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit

class testCollectionViewController: UIViewController {
    
    
    struct SettingOption {
        let iconName: String
        let title: String
    }


    // Setting options
    let settingOptions = [
        SettingOption(iconName: "person.circle.fill", title: "gmail 정보"),
        SettingOption(iconName: "bell.fill", title: "아이디 정보"),
        SettingOption(iconName: "hand.raised.fill", title: "Privacy"),
        SettingOption(iconName: "doc.fill", title: "Terms of Service"),
        SettingOption(iconName: "arrowshape.turn.up.left.fill", title: "Sign Out")
    ]
    
    // Collection view
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: SettingCell.reuseIdentifier)
//        collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        view.addSubview(collectionView)

        
        view.backgroundColor = .white
    }
}

extension testCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let settingCell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.reuseIdentifier, for: indexPath) as! SettingCell
        let settingOption = settingOptions[indexPath.row]
        settingCell.iconView.image = UIImage(systemName: settingOption.iconName)
        settingCell.titleLabel.text = settingOption.title
        return settingCell
    }
}

extension testCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("안녕")
            break
        case 1:
            // Notification setting
            break
        case 2:
            // Privacy setting
            break
        case 3:
            // Terms of Service setting
            break
        case 4:
            // Sign out
            print("나가기")
            break
        default:
            break
        }
    }
}

class SettingCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SettingCell"
    
    var contentBackgroundView = UIView().then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 30.0
    }
    
    let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
//        imageView.backgroundColor = .red
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .label
        return label
    }()
    
    let arrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [
            contentBackgroundView,
            iconView,
            titleLabel,
            arrowView
        ].forEach { self.addSubview($0) }
        
        contentBackgroundView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(70.0)
        }
        
        iconView.snp.makeConstraints {
            $0.centerY.equalTo(contentBackgroundView.snp.centerY)
            $0.width.height.equalTo(25.0)
            $0.leading.equalTo(contentBackgroundView.snp.leading).inset(16.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(16.0)
            $0.centerY.equalTo(iconView.snp.centerY)
        }
        
        arrowView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.height.width.equalTo(20.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }
}

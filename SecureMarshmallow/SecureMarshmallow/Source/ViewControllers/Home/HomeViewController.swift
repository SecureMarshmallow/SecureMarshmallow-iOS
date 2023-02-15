//
//  HomeViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/15.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class HomeViewController: BaseVC {
    
    let sectionInsets = UIEdgeInsets(top: 5, left: 25, bottom: 5, right: 25)
    var array = ["0","1","2","3","4","5","6","7","8"]
    
    private lazy var homeGradationBackground = UIImageView().then {
        let imageName = "HomeBackground"
        $0.image = UIImage(named: imageName)
    }
    
    private lazy var firstTitle = UILabel().then {
        $0.text = "더욱 간편하게 확인하세요"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 1
        $0.textColor = .white
    }
    
    private lazy var secondTitle = UILabel().then {
        $0.text = "어쩌고 저쩌고어쩌고 저쩌고어쩌고 저쩌고어쩌고 저쩌고어쩌고 저쩌고\n어쩌고 저쩌고어쩌고 저쩌고어쩌고 저쩌고"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 2
        $0.textColor = .white
    }
    
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        cv.register(BlurCell.self, forCellWithReuseIdentifier: BlurCell.identifier)
        return cv
    }()
    
    
    override func attribute() {
        collectionView.delegate = self
        
        let data = Observable<[String]>.of(self.array)
        
        print("구독은 됨")
        
            data.asObservable()
                .bind(to: self.collectionView.rx
                    .items(cellIdentifier: BlurCell.identifier, cellType: BlurCell.self)
                ) { index, recommend, cell in
                    print("BlurCell 데이터불러오기 성공")
                    
                    if index == 0 {
                        cell.text = "메모"
                    } else if index == 1 {
                        cell.text = "신용"
                    } else if index == 2 {
                        cell.text = "일기"
                    } else if index == 3 {
                        cell.text = "사진"
                    } else if index == 4 {
                        cell.text = "운전면허증"
                    } else if index == 5 {
                        cell.text = "주민등록번호"
                    } else if index == 6 {
                        cell.text = "비밀번호"
                    } else {
                        cell.text = "계좌"
                    }
                }.disposed(by: disposeBag)
    }
    
    override func layout() {
        [
            homeGradationBackground,
            firstTitle,
            secondTitle,
            collectionView
        ].forEach { view.addSubview($0) }
        
        homeGradationBackground.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(700.0)
            $0.width.equalTo(400.0)
        }
        
        firstTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(78.0)
            $0.leading.equalToSuperview().inset(25.0)
        }
        
        secondTitle.snp.makeConstraints {
            $0.top.equalTo(firstTitle.snp.bottom).offset(20.0)
            $0.leading.equalTo(firstTitle.snp.leading)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(secondTitle.snp.bottom).offset(30.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSpacing : CGFloat = 10
//
//        let width : CGFloat = (collectionView.bounds.width - 65 - itemSpacing * 2) / 2
        
        return CGSize(width: 185, height: 185)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

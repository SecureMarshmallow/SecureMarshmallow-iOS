//
//  AddSecretViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/16.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class AddSecretViewController: BaseVC {
    
    let sectionInsets = UIEdgeInsets(top: 5, left: 25, bottom: 5, right: 25)
    var array = ["0","1","2","3","4","5","6","7","8"]

    private lazy var itemTitle = UILabel().then {
        $0.text = "항목을 선택해주세요"
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.numberOfLines = 1
        $0.textColor = .white
    }
    
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        cv.register(AddSecretCollectionViewCell.self, forCellWithReuseIdentifier: AddSecretCollectionViewCell.identifier)
        return cv
    }()
    
    override func attribute() {
        super.attribute()
        
        collectionView.dataSource = nil
        collectionView.delegate = self
        
        let data = Observable<[String]>.of(self.array)
        
        data.asObservable()
            .bind(to: self.collectionView.rx
                .items(cellIdentifier: AddSecretCollectionViewCell.identifier, cellType: AddSecretCollectionViewCell.self)
            ) { index, recommend, cell in
                cell.layout()
                print("추가 collectionView 잘되고 있습니다")
                
                if index == 0 {
                    cell.text = "비밀번호"
                } else if index == 1 {
                    cell.text = "메모"
                } else if index == 2 {
                    cell.text = "계좌번호"
                } else if index == 3 {
                    cell.text = "카드"
                } else if index == 4 {
                    cell.text = "바코드"
                } else if index == 5 {
                    cell.text = "주민등록증"
                } else if index == 6 {
                    cell.text = "운전면허증"
                } else if index == 7 {
                    cell.text = "여권"
                } else {
                    cell.text = "계좌"
                }
            }.disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.largestUndimmedDetentIdentifier = .large
            let id = UISheetPresentationController.Detent.Identifier("AddCustom")
            let SignCustomDetent = UISheetPresentationController.Detent.custom(identifier: id) { context in
                return 600
            }
            sheetPresentationController.detents = [SignCustomDetent]
        }
    }
    
    override func layout() {
        super.layout()
        
        [
            itemTitle,
            collectionView
        ].forEach { view.addSubview($0) }
        
        itemTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25.0)
            $0.left.equalToSuperview().inset(20.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(itemTitle.snp.bottom).offset(20.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension AddSecretViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: UIScreen.main.bounds.width - 20, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let viewController = UINavigationController(rootViewController: AddPasswordViewController())
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: false)
        
    }
}


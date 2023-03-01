//
//  AddSecretViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/16.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

@available(iOS 16.0, *)
class SecretViewController: BaseVC {
    
    var array = ["0","1","2","3","4","5","6","7","8","3","3"]
    let sectionInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)

    private lazy var addSecretButton = UIButton().then {
        let image = UIImage(named: "AddPostButton")
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        cv.register(SecretCollectionViewCell.self, forCellWithReuseIdentifier: SecretCollectionViewCell.identifier)
        return cv
    }()
    
    override func attribute() {
        super.attribute()
        
        view.backgroundColor = .black
        initSearchBar()
        
        collectionView.delegate = self
        collectionView.dataSource = nil
        
        let data = Observable<[String]>.of(self.array)
        
        print("구독은 됨")
        
        data.asObservable()
            .bind(to: self.collectionView.rx
                .items(cellIdentifier: SecretCollectionViewCell.identifier, cellType: SecretCollectionViewCell.self)
            ) { index, recommend, cell in
                cell.layout()
                
            }.disposed(by: disposeBag)
    }
    
    override func layout() {
        super.layout()
        
        [
            collectionView,
            addSecretButton
        ].forEach { view.addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        addSecretButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(762.0)
            $0.trailing.equalToSuperview().inset(30.0)
            $0.height.width.equalTo(55.0)
        }
    }
    
    override func touchEvent() {
        super.touchEvent()
        
        addSecretButton.rx.tap
            .bind {
                print("asdf")
                self.upView()
            }
    }
    
    func upView() {
        Observable<Int>.interval(.seconds(Int(0)), scheduler: MainScheduler.instance)
            .take(0)
            .subscribe(onNext: { value in
              print(value)
            }, onError: { error in
              print(error)
            }, onCompleted: {
              print("onCompleted")
            }, onDisposed: {
              print("onDisposed")
            })
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {

            let LoginViewContoller = AddSecretViewController()
            self.present(LoginViewContoller, animated: true)
        }
    }
    
    private func initSearchBar() {
//        let search = UIBarButtonItem(systemItem: .search, primaryAction: UIAction(handler: { _ in
//            // search action
//        }))
        let search = UIBarButtonItem(image: UIImage(named: "SettingButton"), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = search
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 0))
        searchBar.placeholder = "찾으시는 것을 검색해보세요"
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
//        searchBar.setImage(UIImage(named: "icCancel"), for: .clear, state: .normal)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
}


@available(iOS 16.0, *)
extension SecretViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)가 눌렸어")
    }
}

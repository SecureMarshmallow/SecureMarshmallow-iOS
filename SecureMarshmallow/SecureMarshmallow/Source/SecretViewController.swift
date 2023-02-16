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

class SecretViewController: BaseVC {

    private lazy var addSecretButton = UIButton().then {
        let image = UIImage(named: "AddPostButton")
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    override func attribute() {
        super.attribute()
        
        view.backgroundColor = .black
    }
    
    override func layout() {
        super.layout()
        
        [
            addSecretButton
        ].forEach { view.addSubview($0) }
        
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
}

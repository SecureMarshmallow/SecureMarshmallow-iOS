//
//  PattenPasswordViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/24.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import CCGestureLock

final class PattenPasswordViewController: BaseVC {
    
    private lazy var gestureLock = CCGestureLock().then { _ in
    }
    
    private lazy var backgroundView = UIView().then {
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 90 * (view.frame.width / 430)
    }
    
    private lazy var emojiCharacter = UILabel().then {
        $0.font = .systemFont(ofSize: 150.0, weight: .black)
        $0.text = "🦁"
    }
    
    override func layout() {
        [
            backgroundView,
            emojiCharacter,
            gestureLock
        ].forEach { view.addSubview($0) }
        
        let width = view.frame.width / 430
        let height = view.frame.height / 932
        
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(180.0 * height)
            $0.width.equalTo(180.0 * width)
        }
        
        emojiCharacter.snp.makeConstraints {
            $0.centerY.equalTo(backgroundView.snp.centerY)
            $0.centerX.equalTo(backgroundView.snp.centerX)
        }
        
        gestureLock.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureLock()
        gestureLock.gestureLockState = .normal
    }
    
    func setupGestureLock() {
        
        //간격 조절
        gestureLock.lockSize = (numHorizontalSensors: 3, numVerticalSensors: 3)
        
        // 가장자리 간격 (숫자 늘리면 원들이 더 모여짐)
        gestureLock.edgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        
        
        // 선택 안되어 있을 때 기본 안쪽 작은 원 색깔
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 5,
            width: 1,
            color: .lightGray,
            forState: .normal
        )
        
        // 색 바꿔봐도 변하지 않음 .clear 디폴트
        gestureLock.setSensorAppearance(
            type: .outer,
            color: .white,
            forState: .normal
        )
        
        // 그냥 선택할 때 안쪽 작은 원 색깔
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 3,
            width: 5,
            color: .white,
            forState: .selected
        )
        
        // 그냥 선택 할 때 바깥쪽 큰 원 색깔
        gestureLock.setSensorAppearance(
            type: .outer,
            radius: 30,
            width: 5,
            color: .white,
            forState: .selected
        )
        
        // 에러 일 때 바뀌는 안쪽 작은 원 색깔
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 3,
            width: 5,
            color: .red,
            forState: .error
        )
        
        // 에러 일 때 바뀌는 바깥쪽 큰 원 색깔
        // 여기서 진짜 빤짝이는 에러가 난다
        gestureLock.setSensorAppearance(
            type: .outer,
            radius: 30,
            width: 5,
            color: .red,
            forState: .error
        )
        
        
        // 이어지는 선 색깔
        [CCGestureLock.GestureLockState.normal, CCGestureLock.GestureLockState.selected].forEach { (state) in
            gestureLock.setLineAppearance(
                width: 5.5,
                color: UIColor.white.withAlphaComponent(0.5),
                forState: state
            )
        }
        
        // 패턴 실패했을 때 바뀌는 선 색깔
        gestureLock.setLineAppearance(
            width: 5.5,
            color: UIColor.red.withAlphaComponent(0.5),
            forState: .error
        )
        gestureLock.addTarget(self,action: #selector(gestureComplete),for: .gestureComplete)
    }
    
    @objc
    func gestureComplete(gestureLock: CCGestureLock) {
        let lockSequence = gestureLock.lockSequence
        
        var dataString = ""
        for seq in lockSequence{
            dataString.append("\(seq)")
        }
        print("패턴 번호: \(dataString)")
        
        if dataString == "0125" {
            // true 값
            gestureLock.gestureLockState = .normal
            print("반가워!!")
        } else {
            // false 값
            print("저기로 꺼져!")
            gestureLock.gestureLockState = .error
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                gestureLock.gestureLockState = .normal
            })
        }
    }
}

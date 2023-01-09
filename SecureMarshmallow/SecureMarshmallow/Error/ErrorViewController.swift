//
//  ViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/01/06.
//

import UIKit
import RxSwift
import SnapKit
import Then
import Lottie

class ErrorViewController: UIViewController {
    
    var started = false
    var isTimerRunning = false
    var lapCounter = 0
    var mainLapCounter = 0
    var lapTimer : Timer?
    var mainLapTimer : Timer?
    var maxIndex = 0
    var minIndex = 0
    var colorCell = false
    
    private let disposeBag = DisposeBag()
    internal var animationView: LottieAnimationView?
    internal let errorTimer = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 40, weight: .bold)
    }
    
    private let testTimer = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 40, weight: .bold)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .ErrorColor
        self.view.addSubview(errorTimer)
        
        self.view.addSubview(testTimer)
        startTimer()
        
        
        animationView = .init(name: "FireLottie")
                
        animationView!.loopMode = .loop
                
        animationView!.animationSpeed = 0.1
        
        animationView!.center = view.center
        
        animationView!.contentMode = .scaleAspectFill
        
        view.addSubview(animationView!)
        
        self.animationView!.snp.makeConstraints {
            $0.top.equalToSuperview().offset(180)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(155)
        }
        
        self.errorTimer.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.testTimer.snp.makeConstraints {
            $0.top.equalTo(animationView!.snp.bottom).offset(30.0)
            $0.centerX.equalToSuperview()
        }
        
        animationView!.play()
        layout()
                
    }
    
    func startTimer(){
        if mainLapTimer == nil{
            mainLapTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mainLapTimerUpdate), userInfo: nil, repeats: true)
            RunLoop.current.add(mainLapTimer!, forMode: .common)
        }
        if lapTimer == nil{
            lapTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(lapTimerUpdate), userInfo: nil, repeats: true)
            RunLoop.current.add(lapTimer!, forMode: .common)
        }
    }


    func updateLabel( label : UILabel, counter : Int){
        let threeMinutes: Int = 180
        testTimer.text = secondsToHourMinuteSecond(seconds: Int(threeMinutes - counter))
    }
    
    func secondsToHourMinuteSecond( seconds : Int )->String{
        let minute = seconds / 60 % 60
        let second = seconds % 60
        return String(format: "%02i:%02i", minute, second )
    }
    
    
    @objc func mainLapTimerUpdate(){
        mainLapCounter -= 1
        updateLabel(label: testTimer, counter: mainLapCounter)
    }
    
    @objc func lapTimerUpdate(){
        lapCounter -= 1
    }
    
    func attributes() {
        
    }
    
    //    private func setupPossibleBackgroundTimer() {
    //        let startTime = Date()
    //
//            let threeMinutes: Int = 180
    //
    //        let timer = Observable<Int>.interval(
    //            .seconds(1),
    //            scheduler: MainScheduler.instance
    //        )
    //        timer.withUnretained(self)
    //            .do(onNext: { weakSelf, countValue in
    //                let elapseSeconds = Date().timeIntervalSince(startTime)
    //                weakSelf.errorTimer.text = "\(threeMinutes - Int(elapseSeconds))분"
    //            })
    //                .subscribe()
    //                .disposed(by: disposeBag)
    //    }lottieMove
}
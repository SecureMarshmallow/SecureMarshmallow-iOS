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
        $0.text = "π¦"
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
        
        //κ°κ²© μ‘°μ 
        gestureLock.lockSize = (numHorizontalSensors: 3, numVerticalSensors: 3)
        
        // κ°μ₯μλ¦¬ κ°κ²© (μ«μ λλ¦¬λ©΄ μλ€μ΄ λ λͺ¨μ¬μ§)
        gestureLock.edgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        
        
        // μ ν μλμ΄ μμ λ κΈ°λ³Έ μμͺ½ μμ μ μκΉ
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 5,
            width: 1,
            color: .lightGray,
            forState: .normal
        )
        
        // μ λ°κΏλ΄λ λ³νμ§ μμ .clear λν΄νΈ
        gestureLock.setSensorAppearance(
            type: .outer,
            color: .white,
            forState: .normal
        )
        
        // κ·Έλ₯ μ νν  λ μμͺ½ μμ μ μκΉ
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 3,
            width: 5,
            color: .white,
            forState: .selected
        )
        
        // κ·Έλ₯ μ ν ν  λ λ°κΉ₯μͺ½ ν° μ μκΉ
        gestureLock.setSensorAppearance(
            type: .outer,
            radius: 30,
            width: 5,
            color: .white,
            forState: .selected
        )
        
        // μλ¬ μΌ λ λ°λλ μμͺ½ μμ μ μκΉ
        gestureLock.setSensorAppearance(
            type: .inner,
            radius: 3,
            width: 5,
            color: .red,
            forState: .error
        )
        
        // μλ¬ μΌ λ λ°λλ λ°κΉ₯μͺ½ ν° μ μκΉ
        // μ¬κΈ°μ μ§μ§ λΉ€μ§μ΄λ μλ¬κ° λλ€
        gestureLock.setSensorAppearance(
            type: .outer,
            radius: 30,
            width: 5,
            color: .red,
            forState: .error
        )
        
        
        // μ΄μ΄μ§λ μ  μκΉ
        [CCGestureLock.GestureLockState.normal, CCGestureLock.GestureLockState.selected].forEach { (state) in
            gestureLock.setLineAppearance(
                width: 5.5,
                color: UIColor.white.withAlphaComponent(0.5),
                forState: state
            )
        }
        
        // ν¨ν΄ μ€ν¨νμ λ λ°λλ μ  μκΉ
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
        print("ν¨ν΄ λ²νΈ: \(dataString)")
        
        if dataString == "0125" {
            // true κ°
            gestureLock.gestureLockState = .normal
            print("λ°κ°μ!!")
        } else {
            // false κ°
            print("μ κΈ°λ‘ κΊΌμ Έ!")
            gestureLock.gestureLockState = .error
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                gestureLock.gestureLockState = .normal
            })
        }
    }
}

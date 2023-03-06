import UIKit
import SnapKit
import Then

//캐릭터 선택을 맞히고 완료된 view를 의미 합니다.
class CompleteViewController: UIViewController {
    
    //유저가 선택한 바탕을 선언합니다.
    private lazy var backgroundView = UIView().then {
        $0.layer.cornerRadius = 100 * (view.frame.width / 430)
    }
    
    //유저가 선택한 캐릭터를 보여줍니다.
    private lazy var emojiCharacter = UILabel().then {
        $0.font = .systemFont(ofSize: 150.0, weight: .black)
        $0.text = ""
    }
    
    //말 그대로 환영합니다. title이 나오도록 선언되었습니다.
    private lazy var welcomeTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 24.0, weight: .semibold)
        $0.text = "%s님 환영합니다"
    }
    
    //proFile이 처음으로 갱신된 시간을 가져옵니다.
    private lazy var profileUpdateMessage = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .regular)
        $0.text = "2023.02.07 프로필 업데이트"
        $0.textColor = .separator

    }
    
    //완료 버튼을 선언합니다.
    private lazy var completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(UIColor(ciColor: .black), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25 * (view.frame.width / 430)
        $0.layer.borderWidth = 0.0
    }
    
    // view의 생명주기에서 뷰가 나타나기 직전 호출될 떄 호출됩니다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        backgroundView.backgroundColor = CharacterSelectionViewController.userBackground
        emojiCharacter.text = CharacterSelectionViewController.userEmoji
    }
    
    //view의 생명주기에서 뷰의 메모리가 로드된 후 호출됩니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        layout()
    }
    
    //layout을 선언합니다.
    func layout() {
        [
            backgroundView,
            emojiCharacter,
            welcomeTitle,
            profileUpdateMessage,
            completeButton
        ].forEach { view.addSubview($0) }
        
        let width = view.frame.width / 430
        let height = view.frame.height / 932
        
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200.0 * height)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200.0 * height)
            $0.width.equalTo(200.0 * width)
        }
        
        emojiCharacter.snp.makeConstraints {
            $0.centerY.equalTo(backgroundView.snp.centerY)
            $0.centerX.equalTo(backgroundView.snp.centerX)
        }
        
        welcomeTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backgroundView.snp.bottom).offset(75.0 * height)
        }
        
        profileUpdateMessage.snp.makeConstraints {
            $0.centerX.equalTo(welcomeTitle.snp.centerX)
            $0.top.equalTo(welcomeTitle.snp.bottom).offset(10.0 * height)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(profileUpdateMessage.snp.bottom).offset(230.0 * height)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(260.0 * width)
            $0.height.equalTo(55.0 * height)
        }
    }
    
    
}

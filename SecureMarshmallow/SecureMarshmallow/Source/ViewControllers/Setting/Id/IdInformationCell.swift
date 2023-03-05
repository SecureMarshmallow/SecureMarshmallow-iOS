import UIKit
import Then
import SnapKit

class IdCell: UITableViewCell {
    
    //여기 IdCell에 이름이라고 생각하면됩니다.
    static let reuseIdentifier = "IdCell"
    
    //iConImageView 선언
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .systemBlue
    }
    
    //titleLabel 선언
    internal let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    //switchControl 선언
    private let switchControl = UISwitch().then {
        $0.onTintColor = .systemGreen
        $0.isHidden = true
    }
    
    // stackView는 iconImageVIew와titleLabel,UIView,switchControl를 하나로 묶어주는 일을 합니다.
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, UIView(), switchControl])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    //stackView의 간격을 명시하고 추가합니다.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    // 필수 생성자
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //configure에 item을 받으면 IdItem이 cell에 추가 됩니다 IdItem을 받는 것은 cellForItemAt 에 가면 configure를 사용할 것을 볼 수 있습니다.
    func configure(with item: IdItem) {
        titleLabel.text = item.type.title
        switchControl.isOn = item.switchState
        switchControl.isHidden = !item.hasSwitch
    }
}

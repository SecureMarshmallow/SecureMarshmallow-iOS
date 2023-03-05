import UIKit

class SettingsCell: UITableViewCell {
    
    //여기 SettingsCell에 이름이라고 생각하면됩니다.
    static let reuseIdentifier = "SettingsCell"
    
    //iConImageView 선언
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    //titleLabel 선언
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    //switchControl 선언
    private let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = .systemGreen
        switchControl.isHidden = true
        return switchControl
    }()
    
    // stackView는 iconImageView와titleLabel,UIView,switchControl를 하나로 묶어주는 일을 합니다.
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
    
    //configure에 item을 받으면 SettingsItem이 cell에 추가 됩니다 SettingsItem을 받는 것은 cellForItemAt 에 가면 configure를 사용할 것을 볼 수 있습니다.
    func configure(with item: SettingsItem) {
        iconImageView.image = item.type.icon
        titleLabel.text = item.type.title
        switchControl.isOn = item.switchState
        switchControl.isHidden = !item.hasSwitch
    }
}

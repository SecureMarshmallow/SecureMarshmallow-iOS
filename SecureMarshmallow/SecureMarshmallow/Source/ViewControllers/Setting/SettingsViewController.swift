import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties

    //tableView를 선언해줍니다.
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    //사전에 만든 settingsItems을 배열로 받아옵니다.
    private var settingsItems: [[SettingsItem]] = []

    // MARK: - Lifecycle

    //view 생명주기의 한부분으로 메모리에 로드되고 난 후 호출됩니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureSettingsItems()
    }

    // MARK: - Helpers

    //configureUI는 잡동산이를 처리합니다.
    private func configureUI() {
        view.backgroundColor = .systemBackground
//        title = "Settings"
    }

    //configureTableView는 tableView를 선언하고 tableView layout과 관련된 일을 합니다.
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    //configureSettingsItems은 말그대로 SettingsItem에 있는 것을 추가해서 tableView에 반영시킵니다.
    private func configureSettingsItems() {
//        let section1 = [SettingsItem(type: .account),
//                        SettingsItem(type: .notification, hasSwitch: true, switchState: true)]
        let section1 = [SettingsItem(type: .gmailInformation),
                        SettingsItem(type: .idInformation)]
        let section2 = [SettingsItem(type: .appPassword),
                        SettingsItem(type: .intrusionInformation),
                        SettingsItem(type: .appTracking)]

        let section3 = [SettingsItem(type: .changeAppIcon),
                        SettingsItem(type: .changeAppTheme)]

        let section4 = [SettingsItem(type: .help),
                        SettingsItem(type: .bugReport)]

        let section5 = [SettingsItem(type: .feedback)]

        let section6 = [SettingsItem(type: .appShare),
                        SettingsItem(type: .privacyPolicy),
                        SettingsItem(type: .termsofUse)]

        let section7 = [SettingsItem(type: .howToUse),
                        SettingsItem(type: .developerIformation)]
//        let section3 = [SettingsItem(type: .appTracking)]
        settingsItems = [section1, section2, section3, section4, section5, section6, section7]
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {

    // 각 섹션의 footer 뷰 설정
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    //색션의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsItems.count
    }

    //cell의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems[section].count
    }

    //cell의 특징
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as! SettingsCell
        let item = settingsItems[indexPath.section][indexPath.row]
        cell.configure(with: item)
        return cell
    }

}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {

    //cell의 간격
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    // 셀 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    //cell을 클릭했을 경우
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = settingsItems[indexPath.section][indexPath.row]
        switch item.type {
        case .gmailInformation:
            print("gmail")
            let gmailVC = GmailInformationViewController()
            gmailVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(gmailVC, animated: true)
            break
        case .idInformation:
            print("id")
            let idVC = IdInformationViewController()
            idVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(idVC, animated: true)
            break
        case .intrusionInformation:
            // Handle help action
            break
        case .appPassword:
            // Handle notification switch action
            break
        case .appTracking:
            // Handle logout action
            print("로그아웃")
            break
        case .changeAppIcon:
            print("앱 아이콘 변경")
        case .changeAppTheme:
            print("앱 테마 변경 클릭")
        case .help:
            print("지원")
        case .bugReport:
            print("버그 제보")
        case .feedback:
            print("피드백")
        case .appShare:
            print("앱 공유")
        case .privacyPolicy:
            print("개인정보 처리 방침")
        case .termsofUse:
            print("이용 약관 클릭")
        case .howToUse:
            print("사용 방법")
        case .developerIformation:
            print("개발자 정보")
        }
    }
}

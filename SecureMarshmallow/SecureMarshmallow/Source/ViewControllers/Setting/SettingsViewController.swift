import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var settingsItems: [[SettingsItem]] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureSettingsItems()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
//        title = "Settings"
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        tableView.sectionHeaderHeight = 10 // 간격 설정
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func configureSettingsItems() {
//        let section1 = [SettingsItem(type: .account),
//                        SettingsItem(type: .notification, hasSwitch: true, switchState: true)]
        let section1 = [SettingsItem(type: .gmailInformation),
                        SettingsItem(type: .idInformation)]
        let section2 = [SettingsItem(type: .intrusionInformation),
                        SettingsItem(type: .appPassword),
                        SettingsItem(type: .changeAppIcon)]
//        let section3 = [SettingsItem(type: .appTracking)]
        settingsItems = [section1, section2]
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as! SettingsCell
        let item = settingsItems[indexPath.section][indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .systemGroupedBackground
//
//        let titleLabel = UILabel()
//        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
//        titleLabel.text = section == 0 ? "ACCOUNT" : (section == 1 ? "HELP" : "LOG OUT")
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        headerView.addSubview(titleLabel)
//        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
//
//        return headerView
//    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = settingsItems[indexPath.section][indexPath.row]
        switch item.type {
        case .gmailInformation:
            print("gmail")
            break
        case .idInformation:
            // Handle account action
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
        }
    }
}
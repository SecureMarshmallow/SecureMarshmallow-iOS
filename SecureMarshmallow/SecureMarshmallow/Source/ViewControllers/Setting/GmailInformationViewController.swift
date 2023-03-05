import UIKit
import SnapKit
import Then

class GmailInformationViewController: UIViewController {
    
    //tableView를 선언해줍니다.
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    //사전에 만든 gamilItems을 배열로 받아옵니다.
    private var gamilItems: [[GmailItem]] = []
    
    //view 생명주기의 한부분으로 메모리에 로드되고 난 후 호출됩니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
        configureSettingsItems()
    }
    
    //configureUI는 잡동산이를 처리합니다.
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "gmail 정보"
    }
    
    //configureTableView는 tableView를 선언하고 tableView layout과 관련된 일을 합니다.
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GmailCell.self, forCellReuseIdentifier: GmailCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)
        }
        
    }
    
    //configureSettingsItems은 말그대로 GmailItem에 있는 것을 추가해서 tableView에 반영시킵니다.
    private func configureSettingsItems() {
        let section1 = [GmailItem(type: .restoreEmail)]
        let section2 = [GmailItem(type: .deleteAccount)]
        
        gamilItems = [section1, section2]
    }
}

// MARK: - UITableViewDataSource

extension GmailInformationViewController: UITableViewDataSource {

    // 각 섹션의 footer 뷰 설정
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    //색션의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return gamilItems.count
    }

    //cell의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamilItems[section].count
    }

    //cell의 특징
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GmailCell.reuseIdentifier, for: indexPath) as! GmailCell
        let item = gamilItems[indexPath.section][indexPath.row]
        cell.configure(with: item)
        
        if indexPath.row == 0 {
            cell.titleLabel.textColor = .red
        }
        return cell
    }

}

// MARK: - UITableViewDelegate

extension GmailInformationViewController: UITableViewDelegate {

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

        let item = gamilItems[indexPath.section][indexPath.row]
        switch item.type {
        case .restoreEmail:
            print("restoreEmail")
        case .deleteAccount:
            print("deleteAccount")
        }
    }
}

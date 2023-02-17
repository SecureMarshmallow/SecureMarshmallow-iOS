//
//  SettingViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/02.
//

//현재 극심한 에러로 나중에 다시 해야겠다 ㄷㄷ

import UIKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

struct SettingOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}



final class SettingViewController: UIViewController {
    private lazy var presenter = SettingPresenter(viewController: self)
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    override func viewDidLayoutSubviews() {
        tabBarController?.addSubviewToLastTabItem("TemporaryProfile")
    }
    
    func configure() {
        //스위치 관련
//        models.append(Section(title: "", options: [
//            .switchCell(model: SettingsSwitchOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemRed, handler: {
//
//            }, isOn: true))
//        ]))
        
//        models.append(Section(title: "개인정보", options: [
//            .staticCell(model: SettingOption(title: "gmail", icon: UIImage(systemName: ""), iconBackgroundColor: .green, handler: {
//                print("asdfasdf")
//            })),
//            .staticCell(model: SettingOption(title: "아이디 정보", icon: UIImage(systemName: ""), iconBackgroundColor: .green, handler: {
//                print("sdfgsdfgsdfg")
//            }))
//        ]))
        
        models.append(Section(title: "개인정보", options: [
            .staticCell(model: SettingOption(title: "gmail 정보", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                    let idVC = IdInformationViewController()
                    self.navigationController?.pushViewController(idVC, animated: true)
                    print("클릭함")
            }),
            .staticCell(model: SettingOption(title: "아이디 정보", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {

                print("하하")
            })
        ]))
//
        
        models.append(Section(title: "보안", options: [
            .staticCell(model: SettingOption(title: "앱 비밀번호", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
            }),
            .staticCell(model: SettingOption(title: "침입 시도", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            }),
            .staticCell(model: SettingOption(title: "앱 열기 추적", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                print("asdfasdf r")
            })
        ]))
        
        models.append(Section(title: "앱", options: [
            .staticCell(model: SettingOption(title: "앱 아이콘 변경", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            }),
            .staticCell(model: SettingOption(title: "앱 테마 변경", icon: UIImage(systemName: "bluetooth"), iconBackgroundColor: .gray) {
                
            })
        ]))
        
        models.append(Section(title: "", options: [
            .staticCell(model: SettingOption(title: "지원", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            }),
            .staticCell(model: SettingOption(title: "버그 보고하기", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            })
        ]))
        
        models.append(Section(title: "", options: [
            .staticCell(model: SettingOption(title: "피드백", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            })
        ]))
        
        models.append(Section(title: "", options: [
            .staticCell(model: SettingOption(title: "앱 공유", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            }),
            .staticCell(model: SettingOption(title: "개인정보 처리 방침", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            }),
            .staticCell(model: SettingOption(title: "이용 약관", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            })
        ]))
        
        models.append(Section(title: "", options: [
            .staticCell(model: SettingOption(title: "사용 방법", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            }),
            .staticCell(model: SettingOption(title: "개발자 정보", icon: UIImage(systemName: ""), iconBackgroundColor: .gray) {
                
            })
        ]))
    }
}

extension SettingViewController: SettingProtocol {
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections \(models.count)")
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" numberOfRowsInSection \(models[section].options.count)")
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        print("model: \(model)")
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.row].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
    }
}

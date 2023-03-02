//
//  SettingsItemType.swift
//  Pods
//
//  Created by 박준하 on 2023/03/03.
//

import Foundation

enum SettingsItemType {
    case about
    case account
    case notification
    case help
    case logout
    
    var title: String {
        switch self {
        case .about:
            return "About"
        case .account:
            return "Account"
        case .notification:
            return "Notifications"
        case .help:
            return "Help"
        case .logout:
            return "Log out"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .about:
            return UIImage(systemName: "info.circle")
        case .account:
            return UIImage(systemName: "person.circle")
        case .notification:
            return UIImage(systemName: "bell.circle")
        case .help:
            return UIImage(systemName: "questionmark.circle")
        case .logout:
            return UIImage(systemName: "arrow.left.square")
        }
    }
}

struct SettingsItem {
    let type: SettingsItemType
    let hasSwitch: Bool
    let switchState: Bool
    
    init(type: SettingsItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}

//
//  SettingsItemType.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/03/03.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit

enum SettingsItemType {
    case gmailInformation
    case idInformation
    case appPassword
    case intrusionInformation
    case appTracking
    case changeAppIcon
    
    var title: String {
        switch self {
        case .gmailInformation:
            return "gmail 정보"
        case .idInformation:
            return "아이디 정보"
        case .appPassword:
            return "앱 비밀번호"
        case .intrusionInformation:
            return "침입 시도"
        case .appTracking:
            return "앱 열기 추적"
        case .changeAppIcon:
            return "앱 아이콘 변경"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .gmailInformation:
            return UIImage(systemName: "info.circle")
        case .idInformation:
            return UIImage(systemName: "person.circle")
        case .appPassword:
            return UIImage(systemName: "bell.circle")
        case .intrusionInformation:
            return UIImage(systemName: "questionmark.circle")
        case .appTracking:
            return UIImage(systemName: "arrow.left.square")
        case .changeAppIcon:
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

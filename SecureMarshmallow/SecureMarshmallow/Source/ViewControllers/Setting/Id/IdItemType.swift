//
//  IdItemType.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/03/06.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit

enum IdItemType {
    case IdInformation
    
    var title: String {
        switch self {
        case .IdInformation:
            return "유저 아이디"
        }
    }
}

struct IdItem {
    let type: IdItemType
    let hasSwitch: Bool
    let switchState: Bool
    
    init(type: IdItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}

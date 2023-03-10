import UIKit

// IdItemType -> IdItem enum으로 받아오는 거에요
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

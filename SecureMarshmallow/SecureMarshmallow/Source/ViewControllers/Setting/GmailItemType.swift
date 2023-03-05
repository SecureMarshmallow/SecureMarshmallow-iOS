import UIKit

// gmailItemType -> GmailItem enum으로 받아오는 거에요
enum GmailItemType {
    case restoreEmail
    case deleteAccount
    
    var title: String {
        switch self {
        case .restoreEmail:
            return "복구 이메일"
        case .deleteAccount:
            return "계정 삭제"
        }
    }
}

struct GmailItem {
    let type: GmailItemType
    let hasSwitch: Bool
    let switchState: Bool
    
    //init인테 type을 GmailItemType로 받고 hasSwitch와 swithState는 선택적으로 선택할 수 있습니다.
    init(type: GmailItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}

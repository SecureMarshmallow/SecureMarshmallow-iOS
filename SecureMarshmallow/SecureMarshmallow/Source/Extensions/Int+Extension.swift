import Foundation
import UIKit

// int 메소드를 커스텀 했습니다.
extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

import Foundation

extension TimeInterval {
    /// %02d: 빈자리를 0으로 채우고, 2자리 정수로 표현합니다.
    var time: String {
        return String(format:"%02d:%02d", Int(self/60), Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}


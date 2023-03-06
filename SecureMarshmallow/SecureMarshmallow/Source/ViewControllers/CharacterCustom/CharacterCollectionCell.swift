import UIKit
import SnapKit

// cell의 테두리를 정하는 것인데 추후에 깔끔하게 돌아오겠습니다.
class CharacterCollectionCell: UICollectionViewCell {
    
    static let identifier = "CharacterCollectionCell"
    
    var imageView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.layer.borderWidth = 3.0
        $0.layer.borderColor = UIColor.gray.cgColor
//        $0.layer.cornerRadius = 55 * ($0.frame.width)
        //        $0.layer.cornerRadius = Constants.cornerRadius
//        $0.layer.cornerRadius = 55 * ($0.frame.height / 430)
//        view.frame.width / 430
    }
    
    var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 80.0, weight: .black)
        $0.text = ""
    }
    
    //    private enum Color {
    //      static var gradientColors = [
    //        UIColor.systemPink,
    //        UIColor.systemPurple.withAlphaComponent(0.7),
    //        UIColor.systemPurple.withAlphaComponent(0.4),
    //        UIColor.systemBlue.withAlphaComponent(0.3),
    //        UIColor.systemBlue.withAlphaComponent(0.7),
    //        UIColor.systemBlue.withAlphaComponent(0.3),
    //        UIColor.systemPurple.withAlphaComponent(0.4),
    //        UIColor.systemPurple.withAlphaComponent(0.7),
    //      ]
    //    }
    
    //    private enum Constants {
    //      static let gradientLocation = [Int](0..<Color.gradientColors.count)
    //        .map(Double.init)
    //        .map { $0 / Double(Color.gradientColors.count) }
    //        .map(NSNumber.init)
    //        static let cornerRadius = 55.0
    //      static let cornerWidth = 4.0
    //      static let viewSize = CGSize(width: 100, height: 100)
    //    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                print("yes")
                imageView.layer.borderColor = UIColor.yellow.cgColor
                //                animateBorderGradation()
            } else {
                print("no")
                imageView.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    
    func layout() {
        self.backgroundColor = .gray
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    //    private var timer: Timer?
    //
    //    deinit {
    //      self.timer?.invalidate()
    //      self.timer = nil
    //    }
    //
    //    func animateBorderGradation() {
    //      let shape = CAShapeLayer()
    //      shape.path = UIBezierPath(
    //        roundedRect: self.imageView.bounds.insetBy(dx: Constants.cornerWidth, dy: Constants.cornerWidth),
    //        cornerRadius: self.imageView.layer.cornerRadius
    //      ).cgPath
    //      shape.lineWidth = Constants.cornerWidth
    //      shape.cornerRadius = Constants.cornerRadius
    //      shape.strokeColor = UIColor.white.cgColor
    //      shape.fillColor = UIColor.clear.cgColor
    //
    //      let gradient = CAGradientLayer()
    //      gradient.frame = self.imageView.bounds
    //      gradient.type = .conic
    //      gradient.colors = Color.gradientColors.map(\.cgColor) as [Any]
    //      gradient.locations = Constants.gradientLocation
    //      gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
    //      gradient.endPoint = CGPoint(x: 1, y: 1)
    //      gradient.mask = shape
    //      gradient.cornerRadius = Constants.cornerRadius
    //      self.imageView.layer.addSublayer(gradient)
    //
    //      self.timer?.invalidate()
    //      self.timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
    //        gradient.removeAnimation(forKey: "myAnimation")
    //        let previous = Color.gradientColors.map(\.cgColor)
    //        let last = Color.gradientColors.removeLast()
    //        Color.gradientColors.insert(last, at: 0)
    //        let lastColors = Color.gradientColors.map(\.cgColor)
    //
    //        let colorsAnimation = CABasicAnimation(keyPath: "colors")
    //        colorsAnimation.fromValue = previous
    //        colorsAnimation.toValue = lastColors
    //        colorsAnimation.repeatCount = 1
    //        colorsAnimation.duration = 0.2
    //        colorsAnimation.isRemovedOnCompletion = false
    //        colorsAnimation.fillMode = .both
    //        gradient.add(colorsAnimation, forKey: "myAnimation")
    //      }
    //    }
    //}
}

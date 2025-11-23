#if os(iOS)
import UIKit

// MARK: - Shape Types

/// 지원하는 도형 타입
public enum ShapeType {
    case circle
    case triangle
    case star(points: Int = 5)
    case heart
    case polygon(sides: Int)
    case roundedPolygon(sides: Int, cornerRadius: CGFloat)
    case rectangle
    case customPath(path: UIBezierPath)
}

// MARK: - Animation Types

/// 지원하는 애니메이션 타입
public enum AnimationType {
    case colorTransition(from: UIColor, to: UIColor, duration: TimeInterval)
    case scale(from: CGFloat, to: CGFloat, duration: TimeInterval)
    case rotation(angle: CGFloat, duration: TimeInterval)
    case glow(color: UIColor, radius: CGFloat, duration: TimeInterval)
    case position(from: CGPoint, to: CGPoint, duration: TimeInterval)
    case alpha(from: CGFloat, to: CGFloat, duration: TimeInterval)
}

// MARK: - Animatable View

/// 체이닝 가능한 애니메이션을 지원하는 UIView 래퍼
public class AnimatableView {
    public let view: UIView
    private var animations: [AnimationType] = []

    init(view: UIView) {
        self.view = view
    }

    /// 애니메이션 추가 (체이닝 가능)
    @discardableResult
    public func addAnimation(_ animation: AnimationType) -> AnimatableView {
        animations.append(animation)
        return self
    }

    /// 모든 애니메이션 시작
    public func start() {
        for animation in animations {
            applyAnimation(animation)
        }
    }

    private func applyAnimation(_ animation: AnimationType) {
        switch animation {
        case .colorTransition(let from, let to, let duration):
            applyColorTransition(from: from, to: to, duration: duration)

        case .scale(let from, let to, let duration):
            applyScale(from: from, to: to, duration: duration)

        case .rotation(let angle, let duration):
            applyRotation(angle: angle, duration: duration)

        case .glow(let color, let radius, let duration):
            applyGlow(color: color, radius: radius, duration: duration)

        case .position(let from, let to, let duration):
            applyPosition(from: from, to: to, duration: duration)

        case .alpha(let from, let to, let duration):
            applyAlpha(from: from, to: to, duration: duration)
        }
    }

    private func applyColorTransition(from: UIColor, to: UIColor, duration: TimeInterval) {
        view.backgroundColor = from
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse]) {
            self.view.backgroundColor = to
        }
    }

    private func applyScale(from: CGFloat, to: CGFloat, duration: TimeInterval) {
        view.transform = CGAffineTransform(scaleX: from, y: from)
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse]) {
            self.view.transform = CGAffineTransform(scaleX: to, y: to)
        }
    }

    private func applyRotation(angle: CGFloat, duration: TimeInterval) {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = angle
        rotation.duration = duration
        rotation.repeatCount = .infinity
        view.layer.add(rotation, forKey: "rotation")
    }

    private func applyGlow(color: UIColor, radius: CGFloat, duration: TimeInterval) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = 0
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = .zero

        let animation = CABasicAnimation(keyPath: "shadowRadius")
        animation.fromValue = 0
        animation.toValue = radius
        animation.duration = duration
        animation.autoreverses = true
        animation.repeatCount = .infinity
        view.layer.add(animation, forKey: "glow")
    }

    private func applyPosition(from: CGPoint, to: CGPoint, duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse]) {
            self.view.center = to
        }
    }

    private func applyAlpha(from: CGFloat, to: CGFloat, duration: TimeInterval) {
        view.alpha = from
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse]) {
            self.view.alpha = to
        }
    }
}

// MARK: - Shape View

/// 커스텀 도형을 그리는 UIView
private class ShapeView: UIView {
    var shapeType: ShapeType
    var fillColor: UIColor

    init(shapeType: ShapeType, fillColor: UIColor) {
        self.shapeType = shapeType
        self.fillColor = fillColor
        super.init(frame: .zero)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let path: UIBezierPath

        switch shapeType {
        case .circle:
            path = UIBezierPath(ovalIn: rect)

        case .triangle:
            path = UIBezierPath()
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.close()

        case .star(let points):
            path = createStarPath(in: rect, points: points)

        case .heart:
            path = createHeartPath(in: rect)

        case .polygon(let sides):
            path = createPolygonPath(in: rect, sides: sides)

        case .roundedPolygon(let sides, let cornerRadius):
            path = createPolygonPath(in: rect, sides: sides, cornerRadius: cornerRadius)

        case .rectangle:
            path = UIBezierPath(rect: rect)

        case .customPath(let customPath):
            path = customPath
        }

        context.setFillColor(fillColor.cgColor)
        path.fill()
    }

    private func createStarPath(in rect: CGRect, points: Int) -> UIBezierPath {
        let path = UIBezierPath()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.4

        let angleIncrement = .pi * 2 / CGFloat(points * 2)
        var currentAngle: CGFloat = -.pi / 2

        for i in 0..<(points * 2) {
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let point = CGPoint(
                x: center.x + cos(currentAngle) * radius,
                y: center.y + sin(currentAngle) * radius
            )

            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }

            currentAngle += angleIncrement
        }

        path.close()
        return path
    }

    private func createHeartPath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()

        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width / 2, y: height))

        path.addCurve(
            to: CGPoint(x: 0, y: height / 4),
            controlPoint1: CGPoint(x: width / 2, y: height * 3 / 4),
            controlPoint2: CGPoint(x: 0, y: height / 2)
        )

        path.addArc(
            withCenter: CGPoint(x: width / 4, y: height / 4),
            radius: width / 4,
            startAngle: .pi,
            endAngle: 0,
            clockwise: true
        )

        path.addArc(
            withCenter: CGPoint(x: width * 3 / 4, y: height / 4),
            radius: width / 4,
            startAngle: .pi,
            endAngle: 0,
            clockwise: true
        )

        path.addCurve(
            to: CGPoint(x: width / 2, y: height),
            controlPoint1: CGPoint(x: width, y: height / 2),
            controlPoint2: CGPoint(x: width / 2, y: height * 3 / 4)
        )

        path.close()
        return path
    }

    private func createPolygonPath(in rect: CGRect, sides: Int, cornerRadius: CGFloat = 0) -> UIBezierPath {
        let path = UIBezierPath()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        let angleIncrement = .pi * 2 / CGFloat(sides)
        var currentAngle: CGFloat = -.pi / 2

        var points: [CGPoint] = []
        for _ in 0..<sides {
            let point = CGPoint(
                x: center.x + cos(currentAngle) * radius,
                y: center.y + sin(currentAngle) * radius
            )
            points.append(point)
            currentAngle += angleIncrement
        }

        if cornerRadius > 0 {
            // 라운드 처리된 다각형
            for i in 0..<points.count {
                let current = points[i]
                let next = points[(i + 1) % points.count]
                let prev = points[(i - 1 + points.count) % points.count]

                let angle1 = atan2(current.y - prev.y, current.x - prev.x)
                let angle2 = atan2(next.y - current.y, next.x - current.x)

                let startPoint = CGPoint(
                    x: current.x - cos(angle1) * cornerRadius,
                    y: current.y - sin(angle1) * cornerRadius
                )
                let endPoint = CGPoint(
                    x: current.x + cos(angle2) * cornerRadius,
                    y: current.y + sin(angle2) * cornerRadius
                )

                if i == 0 {
                    path.move(to: startPoint)
                }

                path.addLine(to: startPoint)
                path.addQuadCurve(to: endPoint, controlPoint: current)
            }
        } else {
            // 일반 다각형
            path.move(to: points[0])
            for i in 1..<points.count {
                path.addLine(to: points[i])
            }
        }

        path.close()
        return path
    }
}

// MARK: - DYBlinkObject

public class DYBlinkObject {

    public init() {}

    // MARK: - v2.0 API

    /**
     지정된 도형과 크기로 AnimatableView를 생성합니다.

     - Parameters:
        - shape: 생성할 도형 타입
        - size: 도형의 크기
        - color: 도형의 색상 (기본값: .white)
     - Returns: 애니메이션을 추가할 수 있는 AnimatableView 객체
     */
    public func createShape(_ shape: ShapeType, size: CGSize, color: UIColor = .white) -> AnimatableView {
        let shapeView = ShapeView(shapeType: shape, fillColor: color)
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        shapeView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        shapeView.heightAnchor.constraint(equalToConstant: size.height).isActive = true

        return AnimatableView(view: shapeView)
    }

    // MARK: - v1.0 API (하위 호환성)

    /**
     Returns a UIView object with the specified size, corner radius, and background color, and adds a flickering animation to it.

     - Parameters:
        - width: The width of the view.
        - height: The height of the view.
        - radius: The corner radius of the view.
        - color: The color of the view.
     - Returns: A UIView object with the specified size, corner radius, and background color, and a flickering animation.
     */
    public func draw(width: CGFloat, height: CGFloat, radius: CGFloat = 20, color: UIColor = .white) -> UIView {
        let object = UIView()
        object.translatesAutoresizingMaskIntoConstraints = false
        object.backgroundColor = color
        object.layer.cornerRadius = radius
        object.clipsToBounds = true
        object.widthAnchor.constraint(equalToConstant: width).isActive = true
        object.heightAnchor.constraint(equalToConstant: height).isActive = true
        return object
    }

    /**
     Adds a blinking animation to the given `UIView` object.

     - Parameters:
        - object: The `UIView` object to which the blinking animation will be added.
        - duration: The duration of the animation.
        - delay: The delay before the animation starts.
        - minAlpha: The minimum alpha value for the `UIView`.

     - Note: This function uses the `UIView.animate(withDuration:delay:options:animations:)` method to create the blinking animation.

     */
    public func addBlinkingAnimation(to object: UIView, withDuration duration: TimeInterval, delay: TimeInterval, minAlpha: CGFloat) {
        UIView.animate(withDuration: duration, delay: delay, options: [.repeat, .autoreverse]) {
            object.alpha = minAlpha
        }
    }
}
#endif

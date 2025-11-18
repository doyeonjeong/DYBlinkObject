#if os(iOS)
import UIKit

// MARK: - Shape Definitions

/// Represents various shapes that can be created
public enum BlinkShape {
    case rectangle(width: CGFloat, height: CGFloat, cornerRadius: CGFloat = 20)
    case circle(radius: CGFloat)
    case triangle(size: CGFloat)
    case star(points: Int, radius: CGFloat)
    case heart(size: CGFloat)
    case polygon(sides: Int, radius: CGFloat)
    case roundedPolygon(sides: Int, radius: CGFloat, cornerRadius: CGFloat)
    case custom(path: UIBezierPath, size: CGSize)
}

// MARK: - Animation Definitions

/// Represents various animation effects
public enum BlinkAnimation {
    case alpha(from: CGFloat = 1.0, to: CGFloat, duration: TimeInterval, delay: TimeInterval = 0.0)
    case colorTransition(from: UIColor, to: UIColor, duration: TimeInterval, delay: TimeInterval = 0.0)
    case scale(from: CGFloat = 1.0, to: CGFloat = 1.5, duration: TimeInterval, delay: TimeInterval = 0.0)
    case rotation(duration: TimeInterval, delay: TimeInterval = 0.0, clockwise: Bool = true)
    case glow(color: UIColor, radius: CGFloat = 10, duration: TimeInterval = 1.0, delay: TimeInterval = 0.0)
    case position(offsetX: CGFloat = 0, offsetY: CGFloat = 20, duration: TimeInterval, delay: TimeInterval = 0.0)
}

// MARK: - Blink View

/// A custom view that supports shape rendering and animations
public class DYBlinkView: UIView {
    private var shapeLayer: CAShapeLayer?
    private var animations: [BlinkAnimation] = []

    public init(shape: BlinkShape, color: UIColor = .white) {
        super.init(frame: .zero)
        setupShape(shape, color: color)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupShape(_ shape: BlinkShape, color: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        let (path, size) = createPath(for: shape)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = nil
        layer.addSublayer(shapeLayer)
        self.shapeLayer = shapeLayer

        // Set size constraints
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }

    private func createPath(for shape: BlinkShape) -> (UIBezierPath, CGSize) {
        switch shape {
        case .rectangle(let width, let height, let cornerRadius):
            let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: height), cornerRadius: cornerRadius)
            return (path, CGSize(width: width, height: height))

        case .circle(let radius):
            let diameter = radius * 2
            let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diameter, height: diameter))
            return (path, CGSize(width: diameter, height: diameter))

        case .triangle(let size):
            let path = UIBezierPath()
            path.move(to: CGPoint(x: size / 2, y: 0))
            path.addLine(to: CGPoint(x: 0, y: size))
            path.addLine(to: CGPoint(x: size, y: size))
            path.close()
            return (path, CGSize(width: size, height: size))

        case .star(let points, let radius):
            let path = createStarPath(points: points, radius: radius)
            let size = radius * 2
            return (path, CGSize(width: size, height: size))

        case .heart(let size):
            let path = createHeartPath(size: size)
            return (path, CGSize(width: size, height: size))

        case .polygon(let sides, let radius):
            let path = createPolygonPath(sides: sides, radius: radius, cornerRadius: 0)
            let size = radius * 2
            return (path, CGSize(width: size, height: size))

        case .roundedPolygon(let sides, let radius, let cornerRadius):
            let path = createPolygonPath(sides: sides, radius: radius, cornerRadius: cornerRadius)
            let size = radius * 2
            return (path, CGSize(width: size, height: size))

        case .custom(let path, let size):
            return (path, size)
        }
    }

    private func createStarPath(points: Int, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let center = CGPoint(x: radius, y: radius)
        let innerRadius = radius * 0.4
        let angleIncrement = .pi * 2 / CGFloat(points * 2)

        for i in 0..<(points * 2) {
            let angle = angleIncrement * CGFloat(i) - .pi / 2
            let currentRadius = i % 2 == 0 ? radius : innerRadius
            let point = CGPoint(
                x: center.x + currentRadius * cos(angle),
                y: center.y + currentRadius * sin(angle)
            )

            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }

        path.close()
        return path
    }

    private func createHeartPath(size: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let width = size
        let height = size

        // Heart shape
        path.move(to: CGPoint(x: width / 2, y: height * 0.3))

        // Left curve
        path.addCurve(
            to: CGPoint(x: 0, y: height * 0.25),
            controlPoint1: CGPoint(x: width / 2, y: height * 0.1),
            controlPoint2: CGPoint(x: 0, y: height * 0.05)
        )

        path.addCurve(
            to: CGPoint(x: width / 2, y: height),
            controlPoint1: CGPoint(x: 0, y: height * 0.5),
            controlPoint2: CGPoint(x: width / 2, y: height * 0.75)
        )

        // Right curve
        path.addCurve(
            to: CGPoint(x: width, y: height * 0.25),
            controlPoint1: CGPoint(x: width / 2, y: height * 0.75),
            controlPoint2: CGPoint(x: width, y: height * 0.5)
        )

        path.addCurve(
            to: CGPoint(x: width / 2, y: height * 0.3),
            controlPoint1: CGPoint(x: width, y: height * 0.05),
            controlPoint2: CGPoint(x: width / 2, y: height * 0.1)
        )

        path.close()
        return path
    }

    private func createPolygonPath(sides: Int, radius: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        guard sides >= 3 else { return UIBezierPath() }

        let center = CGPoint(x: radius, y: radius)
        let angleIncrement = .pi * 2 / CGFloat(sides)

        var points: [CGPoint] = []
        for i in 0..<sides {
            let angle = angleIncrement * CGFloat(i) - .pi / 2
            let point = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
            points.append(point)
        }

        let path = UIBezierPath()

        if cornerRadius > 0 {
            // Rounded polygon
            for i in 0..<points.count {
                let currentPoint = points[i]
                let nextPoint = points[(i + 1) % points.count]
                let prevPoint = points[(i - 1 + points.count) % points.count]

                if i == 0 {
                    path.move(to: currentPoint)
                }

                let midToNext = CGPoint(
                    x: (currentPoint.x + nextPoint.x) / 2,
                    y: (currentPoint.y + nextPoint.y) / 2
                )

                path.addLine(to: midToNext)
                path.addQuadCurve(to: nextPoint, controlPoint: currentPoint)
            }
            path.close()
        } else {
            // Regular polygon
            for (index, point) in points.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.close()
        }

        return path
    }

    /// Adds an animation to the view
    @discardableResult
    public func addAnimation(_ animation: BlinkAnimation) -> DYBlinkView {
        animations.append(animation)
        applyAnimation(animation)
        return self
    }

    /// Adds multiple animations to the view
    @discardableResult
    public func addAnimations(_ animations: [BlinkAnimation]) -> DYBlinkView {
        animations.forEach { addAnimation($0) }
        return self
    }

    private func applyAnimation(_ animation: BlinkAnimation) {
        switch animation {
        case .alpha(let from, let to, let duration, let delay):
            self.alpha = from
            UIView.animate(withDuration: duration, delay: delay, options: [.repeat, .autoreverse]) {
                self.alpha = to
            }

        case .colorTransition(let fromColor, let toColor, let duration, let delay):
            guard let shapeLayer = shapeLayer else { return }

            let colorAnimation = CABasicAnimation(keyPath: "fillColor")
            colorAnimation.fromValue = fromColor.cgColor
            colorAnimation.toValue = toColor.cgColor
            colorAnimation.duration = duration
            colorAnimation.autoreverses = true
            colorAnimation.repeatCount = .infinity
            colorAnimation.beginTime = CACurrentMediaTime() + delay
            colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

            shapeLayer.add(colorAnimation, forKey: "colorTransition")

        case .scale(let from, let to, let duration, let delay):
            self.transform = CGAffineTransform(scaleX: from, y: from)
            UIView.animate(withDuration: duration, delay: delay, options: [.repeat, .autoreverse]) {
                self.transform = CGAffineTransform(scaleX: to, y: to)
            }

        case .rotation(let duration, let delay, let clockwise):
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.fromValue = 0
            rotationAnimation.toValue = clockwise ? CGFloat.pi * 2 : -CGFloat.pi * 2
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = .infinity
            rotationAnimation.beginTime = CACurrentMediaTime() + delay
            layer.add(rotationAnimation, forKey: "rotation")

        case .glow(let color, let radius, let duration, let delay):
            layer.shadowColor = color.cgColor
            layer.shadowRadius = 0
            layer.shadowOpacity = 0.8
            layer.shadowOffset = .zero
            layer.masksToBounds = false

            let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
            glowAnimation.fromValue = 0
            glowAnimation.toValue = radius
            glowAnimation.duration = duration
            glowAnimation.autoreverses = true
            glowAnimation.repeatCount = .infinity
            glowAnimation.beginTime = CACurrentMediaTime() + delay
            layer.add(glowAnimation, forKey: "glow")

        case .position(let offsetX, let offsetY, let duration, let delay):
            let originalTransform = self.transform
            UIView.animate(withDuration: duration, delay: delay, options: [.repeat, .autoreverse]) {
                self.transform = originalTransform.translatedBy(x: offsetX, y: offsetY)
            }
        }
    }
}

// MARK: - Main Class

public class DYBlinkObject {

    public init() {}

    // MARK: - New API (v2.0)

    /// Creates a view with the specified shape
    /// - Parameters:
    ///   - shape: The shape to draw
    ///   - color: The color of the shape (default: white)
    /// - Returns: A DYBlinkView that can be animated
    public func draw(shape: BlinkShape, color: UIColor = .white) -> DYBlinkView {
        return DYBlinkView(shape: shape, color: color)
    }

    /// Creates a view with the specified shape and animations
    /// - Parameters:
    ///   - shape: The shape to draw
    ///   - color: The color of the shape (default: white)
    ///   - animations: Array of animations to apply
    /// - Returns: A DYBlinkView with animations applied
    public func draw(shape: BlinkShape, color: UIColor = .white, animations: [BlinkAnimation]) -> DYBlinkView {
        let view = DYBlinkView(shape: shape, color: color)
        return view.addAnimations(animations)
    }

    // MARK: - Legacy API (v1.0) - Maintained for backward compatibility

    /// Returns a UIView object with the specified size, corner radius, and background color
    /// - Parameters:
    ///   - width: The width of the view
    ///   - height: The height of the view
    ///   - radius: The corner radius of the view
    ///   - color: The color of the view
    /// - Returns: A UIView object with the specified properties
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

    /// Legacy method name for backward compatibility
    @available(*, deprecated, message: "Use draw(width:height:radius:color:) instead")
    public func drawObject(width: CGFloat, height: CGFloat, radius: CGFloat = 20, color: UIColor = .white) -> UIView {
        return draw(width: width, height: height, radius: radius, color: color)
    }

    /// Adds a blinking animation to the given UIView object
    /// - Parameters:
    ///   - object: The UIView object to animate
    ///   - duration: The duration of the animation
    ///   - delay: The delay before the animation starts
    ///   - minAlpha: The minimum alpha value
    public func addBlinkingAnimation(to object: UIView, withDuration duration: TimeInterval, delay: TimeInterval, minAlpha: CGFloat) {
        UIView.animate(withDuration: duration, delay: delay, options: [.repeat, .autoreverse]) {
            object.alpha = minAlpha
        }
    }
}
#endif

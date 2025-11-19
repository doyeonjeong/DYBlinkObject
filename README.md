# DYBlinkObject

[![CI Status](https://img.shields.io/travis/doyeonjeong/DYBlinkObject.svg?style=flat)](https://travis-ci.org/doyeonjeong/DYBlinkObject)
[![Version](https://img.shields.io/cocoapods/v/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)
[![License](https://img.shields.io/cocoapods/l/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)
[![Platform](https://img.shields.io/cocoapods/p/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)

![Simulator Screen Recording - iPhone 14 Pro - 2023-03-10 at 19 12 04](https://user-images.githubusercontent.com/108422901/224291229-ad353959-d34d-421d-93d7-3628cfc56450.gif)

## Description
DYBlinkObject is a powerful Swift library for creating animated shapes with various effects. Version 2.0 introduces support for multiple shape types and animation effects with a chainable API.

## What's New in v2.0

### 🎨 8 Shape Types
- **Circle**: Perfect circular shapes
- **Triangle**: Three-sided polygons
- **Star**: Customizable star shapes (adjustable points)
- **Heart**: Romantic heart shapes
- **Polygon**: Regular polygons (customizable sides)
- **RoundedPolygon**: Polygons with rounded corners
- **Rectangle**: Classic rectangular shapes
- **CustomPath**: Your own UIBezierPath designs

### ✨ 6 Animation Types
- **Alpha**: Fade in/out effects
- **Scale**: Grow and shrink animations
- **Rotation**: Continuous rotation effects
- **Glow**: Pulsating glow effects
- **ColorTransition**: Smooth color transitions
- **Position**: Movement animations

### 🔗 Chainable API
Combine multiple animations for stunning effects:
```swift
shape
    .addAnimation(.scale(from: 1.0, to: 1.2, duration: 1.0))
    .addAnimation(.glow(color: .systemBlue, radius: 20, duration: 1.5))
    .start()
```

### 🔄 Backward Compatibility
All v1.0 APIs are still supported! Your existing code will continue to work.

## Installation

### CocoaPods

DYBlinkObject is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'DYBlinkObject'
```

### Swift Package Manager

DYBlinkObject is available as a Swift Package. Add the following to your `Package.swift`:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/doyeonjeong/DYBlinkObject.git", from: "2.0.0")
    ],
    ...
)
```

## Quick Start

### 1. Import the library
```swift
import DYBlinkObject
```

### 2. Create an instance
```swift
let blinkObject = DYBlinkObject()
```

### 3. Create a shape
```swift
let circle = blinkObject.createShape(.circle, size: CGSize(width: 100, height: 100), color: .systemBlue)
```

### 4. Add animations and start
```swift
circle
    .addAnimation(.alpha(from: 1.0, to: 0.3, duration: 1.0))
    .start()
```

### 5. Add to your view
```swift
view.addSubview(circle.view)
// Add constraints as needed
```

## Usage Examples

### Example 1: Simple Circle with Alpha Animation
```swift
let circle = blinkObject.createShape(.circle, size: CGSize(width: 80, height: 80), color: .systemBlue)
circle.addAnimation(.alpha(from: 1.0, to: 0.3, duration: 1.0))
circle.start()
```

### Example 2: Triangle with Scale
```swift
let triangle = blinkObject.createShape(.triangle, size: CGSize(width: 80, height: 80), color: .systemGreen)
triangle.addAnimation(.scale(from: 1.0, to: 1.3, duration: 1.5))
triangle.start()
```

### Example 3: Rotating Star
```swift
let star = blinkObject.createShape(.star(points: 5), size: CGSize(width: 80, height: 80), color: .systemYellow)
star.addAnimation(.rotation(angle: .pi * 2, duration: 3.0))
star.start()
```

### Example 4: Glowing Heart
```swift
let heart = blinkObject.createShape(.heart, size: CGSize(width: 80, height: 80), color: .systemPink)
heart.addAnimation(.glow(color: .systemPink, radius: 20, duration: 1.5))
heart.start()
```

### Example 5: Pentagon with Color Transition
```swift
let pentagon = blinkObject.createShape(.polygon(sides: 5), size: CGSize(width: 80, height: 80), color: .systemPurple)
pentagon.addAnimation(.colorTransition(from: .systemPurple, to: .systemOrange, duration: 2.0))
pentagon.start()
```

### Example 6: Multiple Animations (Chainable)
```swift
let hexagon = blinkObject.createShape(.roundedPolygon(sides: 6, cornerRadius: 8),
                                       size: CGSize(width: 80, height: 80),
                                       color: .systemTeal)
hexagon
    .addAnimation(.scale(from: 1.0, to: 1.2, duration: 1.0))
    .addAnimation(.alpha(from: 1.0, to: 0.5, duration: 1.0))
    .start()
```

### Example 7: Custom Path (Diamond)
```swift
let diamondPath = UIBezierPath()
diamondPath.move(to: CGPoint(x: 40, y: 0))
diamondPath.addLine(to: CGPoint(x: 80, y: 40))
diamondPath.addLine(to: CGPoint(x: 40, y: 80))
diamondPath.addLine(to: CGPoint(x: 0, y: 40))
diamondPath.close()

let diamond = blinkObject.createShape(.customPath(path: diamondPath),
                                       size: CGSize(width: 80, height: 80),
                                       color: .systemIndigo)
diamond.addAnimation(.colorTransition(from: .systemIndigo, to: .systemCyan, duration: 2.0))
diamond.start()
```

## v1.0 API (Still Supported)

The original API continues to work for backward compatibility:

```swift
// Create a simple blinking view (v1.0 style)
let object = blinkObject.draw(width: 200, height: 50, radius: 10, color: .white)
blinkObject.addBlinkingAnimation(to: object, withDuration: 1.0, delay: 0.0, minAlpha: 0.3)
```

## API Reference

### Shape Types
```swift
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
```

### Animation Types
```swift
public enum AnimationType {
    case colorTransition(from: UIColor, to: UIColor, duration: TimeInterval)
    case scale(from: CGFloat, to: CGFloat, duration: TimeInterval)
    case rotation(angle: CGFloat, duration: TimeInterval)
    case glow(color: UIColor, radius: CGFloat, duration: TimeInterval)
    case position(from: CGPoint, to: CGPoint, duration: TimeInterval)
    case alpha(from: CGFloat, to: CGFloat, duration: TimeInterval)
}
```

### Core Methods

#### v2.0 API
```swift
// Create a shape
func createShape(_ shape: ShapeType, size: CGSize, color: UIColor = .white) -> AnimatableView

// AnimatableView methods
func addAnimation(_ animation: AnimationType) -> AnimatableView  // Chainable
func start()  // Start all animations
```

#### v1.0 API (Legacy)
```swift
// Create a simple view
func draw(width: CGFloat, height: CGFloat, radius: CGFloat = 20, color: UIColor = .white) -> UIView

// Add blinking animation
func addBlinkingAnimation(to object: UIView, withDuration duration: TimeInterval, delay: TimeInterval, minAlpha: CGFloat)
```

## Running the Example Project

To run the example project:

1. Clone the repo
2. Run `pod install` from the Example directory
3. Open `DYBlinkObject.xcworkspace`
4. Run the project to see all shape and animation examples

## Requirements

- iOS 13.0+
- Swift 5.1+

## Author

doyeonjeong, debby_@kakao.com

## License

DYBlinkObject is available under the MIT license. See the LICENSE file for more info.

---

## Changelog

### v2.0.0
- Added 8 shape types (Circle, Triangle, Star, Heart, Polygon, RoundedPolygon, Rectangle, CustomPath)
- Added 6 animation types (ColorTransition, Scale, Rotation, Glow, Position, Alpha)
- Introduced chainable `.addAnimation()` API
- Maintained full backward compatibility with v1.0
- Enhanced documentation with comprehensive examples

### v1.0.0
- Initial release
- Basic blinking animation support
- Simple rectangle drawing

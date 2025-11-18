# DYBlinkObject

[![CI Status](https://img.shields.io/travis/doyeonjeong/DYBlinkObject.svg?style=flat)](https://travis-ci.org/doyeonjeong/DYBlinkObject)
[![Version](https://img.shields.io/cocoapods/v/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)
[![License](https://img.shields.io/cocoapods/l/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)
[![Platform](https://img.shields.io/cocoapods/p/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)

## Description

A powerful and flexible Swift library for creating animated shapes with various visual effects. From simple blinking rectangles to complex custom shapes with multiple simultaneous animations - DYBlinkObject makes it easy!

### ✨ What's New in v2.0

- 🔷 **Multiple Shape Types**: Circle, Triangle, Star, Heart, Polygon, Rounded Polygon, Rectangle, and Custom Paths
- 🎨 **Rich Animation Effects**: Color transitions, scaling, rotation, glow effects, position changes, and alpha animations
- ⚡ **Chainable API**: Fluent interface for adding multiple animations
- 🔄 **Combine Animations**: Apply multiple effects simultaneously or sequentially
- 🎯 **Easy Customization**: All parameters have sensible defaults but are fully customizable
- 📦 **Backward Compatible**: Existing v1.0 code continues to work

## Installation

### Swift Package Manager (Recommended)

Add DYBlinkObject to your project via Swift Package Manager:

1. In Xcode, go to **File > Add Packages...**
2. Enter the repository URL: `https://github.com/BluePepper-iOS/DYBlinkObject.git`
3. Select version **2.0.0** or later

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/BluePepper-iOS/DYBlinkObject.git", from: "2.0.0")
]
```

### CocoaPods

DYBlinkObject is also available through [CocoaPods](https://cocoapods.org):

```ruby
pod 'DYBlinkObject', '~> 2.0'
```

## Quick Start

```swift
import DYBlinkObject

let blink = DYBlinkObject()

// Create a circle with color transition
let circle = blink.draw(
    shape: .circle(radius: 60),
    animations: [
        .colorTransition(from: .red, to: .yellow, duration: 2.0)
    ]
)

// Add to your view
view.addSubview(circle)
```

## 📚 Usage Guide

### Available Shapes

#### Rectangle
```swift
let rect = blink.draw(
    shape: .rectangle(width: 200, height: 100, cornerRadius: 20),
    color: .blue
)
```

#### Circle
```swift
let circle = blink.draw(
    shape: .circle(radius: 50),
    color: .red
)
```

#### Triangle
```swift
let triangle = blink.draw(
    shape: .triangle(size: 100),
    color: .green
)
```

#### Star
```swift
let star = blink.draw(
    shape: .star(points: 5, radius: 60),
    color: .yellow
)
```

#### Heart
```swift
let heart = blink.draw(
    shape: .heart(size: 80),
    color: .pink
)
```

#### Polygon
```swift
// Regular hexagon
let hexagon = blink.draw(
    shape: .polygon(sides: 6, radius: 60),
    color: .purple
)
```

#### Rounded Polygon
```swift
// Pentagon with rounded corners
let roundedPentagon = blink.draw(
    shape: .roundedPolygon(sides: 5, radius: 60, cornerRadius: 15),
    color: .orange
)
```

#### Custom Path
```swift
let customPath = UIBezierPath()
customPath.move(to: CGPoint(x: 50, y: 0))
customPath.addLine(to: CGPoint(x: 100, y: 50))
customPath.addLine(to: CGPoint(x: 50, y: 100))
customPath.addLine(to: CGPoint(x: 0, y: 50))
customPath.close()

let diamond = blink.draw(
    shape: .custom(path: customPath, size: CGSize(width: 100, height: 100)),
    color: .cyan
)
```

### Available Animations

#### Color Transition
Smoothly transitions between two colors with ease-in-out timing:

```swift
.colorTransition(from: .red, to: .blue, duration: 2.0, delay: 0.0)
```

#### Scale
Scales the shape up and down:

```swift
.scale(from: 1.0, to: 1.5, duration: 1.5, delay: 0.0)
```

#### Rotation
Rotates the shape continuously:

```swift
.rotation(duration: 3.0, delay: 0.0, clockwise: true)
```

#### Glow Effect
Adds a pulsing glow/shadow effect:

```swift
.glow(color: .yellow, radius: 15, duration: 1.0, delay: 0.0)
```

#### Alpha (Transparency)
Fades in and out:

```swift
.alpha(from: 1.0, to: 0.3, duration: 1.5, delay: 0.0)
```

#### Position
Moves the shape back and forth:

```swift
.position(offsetX: 20, offsetY: 0, duration: 1.0, delay: 0.0)
```

### Combining Animations

#### Method 1: Array of Animations
```swift
let star = blink.draw(
    shape: .star(points: 5, radius: 60),
    color: .yellow,
    animations: [
        .rotation(duration: 3.0),
        .scale(from: 1.0, to: 1.2, duration: 1.5),
        .glow(color: .yellow, radius: 10)
    ]
)
```

#### Method 2: Chainable API
```swift
let heart = blink.draw(shape: .heart(size: 100), color: .pink)
    .addAnimation(.scale(from: 1.0, to: 1.3, duration: 1.5))
    .addAnimation(.glow(color: .pink, radius: 15))
    .addAnimation(.rotation(duration: 4.0))
```

## 🎯 Examples

### Pulsing Heart
```swift
let heart = blink.draw(shape: .heart(size: 100), color: .systemPink)
    .addAnimation(.scale(from: 1.0, to: 1.3, duration: 1.5))
    .addAnimation(.glow(color: .systemPink, radius: 15, duration: 1.5))
```

### Rotating Rainbow Star
```swift
let star = blink.draw(
    shape: .star(points: 5, radius: 60),
    animations: [
        .colorTransition(from: .red, to: .purple, duration: 2.0),
        .rotation(duration: 3.0)
    ]
)
```

### Floating Badge
```swift
let badge = blink.draw(
    shape: .roundedPolygon(sides: 6, radius: 50, cornerRadius: 10),
    color: .systemBlue,
    animations: [
        .position(offsetY: 15, duration: 2.0),
        .glow(color: .systemBlue, radius: 8)
    ]
)
```

### Color-Shifting Triangle
```swift
let triangle = blink.draw(shape: .triangle(size: 100), color: .systemGreen)
    .addAnimation(.colorTransition(from: .systemGreen, to: .systemCyan, duration: 2.5))
    .addAnimation(.rotation(duration: 4.0))
```

## 🔄 Migration from v1.0

Your existing v1.0 code continues to work:

```swift
// v1.0 API - Still supported!
let object = blinkObject.draw(width: 200, height: 200, radius: 20)
blinkObject.addBlinkingAnimation(to: object, withDuration: 2.0, delay: 0.0, minAlpha: 0.5)

// v2.0 equivalent
let object = blinkObject.draw(
    shape: .rectangle(width: 200, height: 200, cornerRadius: 20),
    animations: [.alpha(to: 0.5, duration: 2.0)]
)
```

## 📖 API Reference

### BlinkShape

- `.rectangle(width: CGFloat, height: CGFloat, cornerRadius: CGFloat = 20)`
- `.circle(radius: CGFloat)`
- `.triangle(size: CGFloat)`
- `.star(points: Int, radius: CGFloat)`
- `.heart(size: CGFloat)`
- `.polygon(sides: Int, radius: CGFloat)`
- `.roundedPolygon(sides: Int, radius: CGFloat, cornerRadius: CGFloat)`
- `.custom(path: UIBezierPath, size: CGSize)`

### BlinkAnimation

- `.alpha(from: CGFloat = 1.0, to: CGFloat, duration: TimeInterval, delay: TimeInterval = 0.0)`
- `.colorTransition(from: UIColor, to: UIColor, duration: TimeInterval, delay: TimeInterval = 0.0)`
- `.scale(from: CGFloat = 1.0, to: CGFloat = 1.5, duration: TimeInterval, delay: TimeInterval = 0.0)`
- `.rotation(duration: TimeInterval, delay: TimeInterval = 0.0, clockwise: Bool = true)`
- `.glow(color: UIColor, radius: CGFloat = 10, duration: TimeInterval = 1.0, delay: TimeInterval = 0.0)`
- `.position(offsetX: CGFloat = 0, offsetY: CGFloat = 20, duration: TimeInterval, delay: TimeInterval = 0.0)`

## 📱 Requirements

- iOS 13.0+
- Swift 5.1+
- Xcode 11.0+

## Example Project

To run the example project:

1. Clone the repo
2. Open `Example/DYBlinkObject.xcworkspace`
3. Run the project

The example app showcases all available shapes and animations!

## Author

doyeonjeong, debby_@kakao.com

## License

DYBlinkObject is available under the MIT license. See the LICENSE file for more info.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Changelog

### v2.0.0
- ✨ Added multiple shape types (Circle, Triangle, Star, Heart, Polygon, etc.)
- ✨ Added rich animation effects (Color transition, Scale, Rotation, Glow, Position)
- ✨ Chainable API for easy animation composition
- ✨ Support for custom paths
- ✨ Swift Package Manager support enhanced
- 🔄 Maintained backward compatibility with v1.0

### v1.0.0
- Initial release with basic rectangle shapes and alpha animation

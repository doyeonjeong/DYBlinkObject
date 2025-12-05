# DYBlinkObject

[![Version](https://img.shields.io/cocoapods/v/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)
[![License](https://img.shields.io/cocoapods/l/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)
[![Platform](https://img.shields.io/cocoapods/p/DYBlinkObject.svg?style=flat)](https://cocoapods.org/pods/DYBlinkObject)

<div style="display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); 
            gap: 20px; 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 20px 10px;">
  <img src="https://github.com/user-attachments/assets/b834700b-0566-48cf-aa3f-def2a15a8f2b" 
       alt="Demo 3" 
       style="width: 100%; height: auto; border-radius: 12px; box-shadow: 0 6px 16px rgba(0,0,0,0.15);">
  <img src="https://github.com/user-attachments/assets/55a50801-03a0-4175-a8ed-fb45d265a18c" 
       alt="Demo 1" 
       style="width: 100%; height: auto; border-radius: 12px; box-shadow: 0 6px 16px rgba(0,0,0,0.15);">
  <img src="https://github.com/user-attachments/assets/5487e64e-f4d1-4b10-a80c-878cc08d4271" 
       alt="Demo 4" 
       style="width: 100%; height: auto; border-radius: 12px; box-shadow: 0 6px 16px rgba(0,0,0,0.15);">
  <img src="https://github.com/user-attachments/assets/a559753c-918f-4da8-9d06-efb36f6bd229" 
       alt="Demo 2" 
       style="width: 100%; height: auto; border-radius: 12px; box-shadow: 0 6px 16px rgba(0,0,0,0.15);">
</div>

---

## 소개
DYBlinkObject는 다양한 효과를 가진 애니메이션 도형을 만들 수 있는 Swift 라이브러리입니다.
버전 2.0에서는 여러 도형 타입과 애니메이션 효과를 체이닝 가능한 API로 지원합니다.

## 🎮 Interactive Playground
Example 앱에는 실시간으로 shape와 animation을 조합해볼 수 있는 **Interactive Playground**가 포함되어 있습니다!

- **6가지 Shape 타입**: Circle, Triangle, Star, Heart, Pentagon, Hexagon
- **5가지 Animation 타입**: Alpha, Scale, Rotation, Glow, Color
- **실시간 미리보기**: Create 버튼을 눌러 즉시 결과 확인
- **탭 기반 네비게이션**: Playground 탭과 Samples 탭으로 구분된 깔끔한 UI

## v2.0의 새로운 기능

### 🎨 8가지 도형 타입
- **Circle**: 완벽한 원형
- **Triangle**: 삼각형
- **Star**: 커스터마이징 가능한 별 모양 (포인트 개수 조절)
- **Heart**: 하트 모양
- **Polygon**: 정다각형 (변의 개수 조절)
- **RoundedPolygon**: 모서리가 둥근 다각형
- **Rectangle**: 사각형
- **CustomPath**: 직접 만든 UIBezierPath 디자인

### ✨ 6가지 애니메이션 타입
- **Alpha**: 페이드 인/아웃 효과
- **Scale**: 확대/축소 애니메이션
- **Rotation**: 회전 효과
- **Glow**: 맥동하는 빛 효과
- **ColorTransition**: 부드러운 색상 전환
- **Position**: 이동 애니메이션

### 🔗 체이닝 가능한 API
여러 애니메이션을 조합하여 멋진 효과 생성:
```swift
shape
    .addAnimation(.scale(from: 1.0, to: 1.2, duration: 1.0))
    .addAnimation(.glow(color: .systemBlue, radius: 20, duration: 1.5))
    .start()
```

### 🔄 하위 호환성
v1.0의 모든 API가 여전히 지원됩니다! 기존 코드가 계속 작동합니다.

## 설치

### CocoaPods

[CocoaPods](https://cocoapods.org)를 통해 설치할 수 있습니다. Podfile에 다음 줄을 추가하세요:

```ruby
pod 'DYBlinkObject'
```

### Swift Package Manager

Swift Package로도 사용 가능합니다. `Package.swift`에 다음을 추가하세요:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/doyeonjeong/DYBlinkObject.git", from: "2.0.0")
    ],
    ...
)
```

## 빠른 시작

### 1. 라이브러리 import
```swift
import DYBlinkObject
```

### 2. 인스턴스 생성
```swift
let blinkObject = DYBlinkObject()
```

### 3. 도형 만들기
```swift
let circle = blinkObject.createShape(.circle, size: CGSize(width: 100, height: 100), color: .systemBlue)
```

### 4. 애니메이션 추가 및 시작
```swift
circle
    .addAnimation(.alpha(from: 1.0, to: 0.3, duration: 1.0))
    .start()
```

### 5. 뷰에 추가
```swift
view.addSubview(circle.view)
// 필요에 따라 제약조건 추가
```

## 사용 예제

### 예제 1: Alpha 애니메이션이 있는 원
```swift
let circle = blinkObject.createShape(.circle, size: CGSize(width: 80, height: 80), color: .systemBlue)
circle.addAnimation(.alpha(from: 1.0, to: 0.3, duration: 1.0))
circle.start()
```

### 예제 2: Scale 애니메이션이 있는 삼각형
```swift
let triangle = blinkObject.createShape(.triangle, size: CGSize(width: 80, height: 80), color: .systemGreen)
triangle.addAnimation(.scale(from: 1.0, to: 1.3, duration: 1.5))
triangle.start()
```

### 예제 3: 회전하는 별
```swift
let star = blinkObject.createShape(.star(points: 5), size: CGSize(width: 80, height: 80), color: .systemYellow)
star.addAnimation(.rotation(angle: .pi * 2, duration: 3.0))
star.start()
```

### 예제 4: 빛나는 하트
```swift
let heart = blinkObject.createShape(.heart, size: CGSize(width: 80, height: 80), color: .systemPink)
heart.addAnimation(.glow(color: .systemPink, radius: 20, duration: 1.5))
heart.start()
```

### 예제 5: 색상 전환이 있는 오각형
```swift
let pentagon = blinkObject.createShape(.polygon(sides: 5), size: CGSize(width: 80, height: 80), color: .systemPurple)
pentagon.addAnimation(.colorTransition(from: .systemPurple, to: .systemOrange, duration: 2.0))
pentagon.start()
```

### 예제 6: 여러 애니메이션 조합 (체이닝)
```swift
let hexagon = blinkObject.createShape(.roundedPolygon(sides: 6, cornerRadius: 8),
                                       size: CGSize(width: 80, height: 80),
                                       color: .systemTeal)
hexagon
    .addAnimation(.scale(from: 1.0, to: 1.2, duration: 1.0))
    .addAnimation(.alpha(from: 1.0, to: 0.5, duration: 1.0))
    .start()
```

### 예제 7: 커스텀 경로 (다이아몬드)
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

## v1.0 API (여전히 지원됨)

하위 호환성을 위해 기존 API도 계속 작동합니다:

```swift
// 간단한 깜빡이는 뷰 생성 (v1.0 스타일)
let object = blinkObject.draw(width: 200, height: 50, radius: 10, color: .white)
blinkObject.addBlinkingAnimation(to: object, withDuration: 1.0, delay: 0.0, minAlpha: 0.3)
```

## API 레퍼런스

### 도형 타입
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

### 애니메이션 타입
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

### 핵심 메서드

#### v2.0 API
```swift
// 도형 생성
func createShape(_ shape: ShapeType, size: CGSize, color: UIColor = .white) -> AnimatableView

// AnimatableView 메서드
func addAnimation(_ animation: AnimationType) -> AnimatableView  // 체이닝 가능
func start()  // 모든 애니메이션 시작
```

#### v1.0 API (레거시)
```swift
// 간단한 뷰 생성
func draw(width: CGFloat, height: CGFloat, radius: CGFloat = 20, color: UIColor = .white) -> UIView

// 깜빡임 애니메이션 추가
func addBlinkingAnimation(to object: UIView, withDuration duration: TimeInterval, delay: TimeInterval, minAlpha: CGFloat)
```

## 예제 프로젝트 실행

예제 프로젝트를 실행하려면:

1. 저장소를 클론합니다
2. Example 디렉토리에서 `pod install` 실행
3. `DYBlinkObject.xcworkspace` 열기
4. 프로젝트를 실행하여 모든 도형과 애니메이션 예제 확인
5. **Playground 탭**에서 직접 조합을 테스트해보세요!
6. **Samples 탭**에서 미리 만들어진 예제들을 확인하세요

## 요구사항

- iOS 18.0+
- Swift 5.1+

## 작성자

doyeonjeong, debby_@kakao.com

## 라이선스

DYBlinkObject는 MIT 라이선스로 제공됩니다. 자세한 내용은 LICENSE 파일을 참조하세요.

---

## 변경 로그

### v2.0.0
- 8가지 도형 타입 추가 (Circle, Triangle, Star, Heart, Polygon, RoundedPolygon, Rectangle, CustomPath)
- 6가지 애니메이션 타입 추가 (ColorTransition, Scale, Rotation, Glow, Position, Alpha)
- 체이닝 가능한 `.addAnimation()` API 도입
- v1.0과의 완전한 하위 호환성 유지
- Interactive Playground 추가
- 탭 기반 네비게이션으로 개선된 Example 앱
- 포괄적인 예제와 문서 개선

### v1.0.0
- 초기 릴리스
- 기본 깜빡임 애니메이션 지원
- 간단한 사각형 그리기

# iOS 18.0 호환성 수정 및 Interactive Playground 추가

## 📝 요약
Example 앱의 iOS 18.0 호환성 문제를 해결하고, 사용자가 직접 shape와 animation을 조합해볼 수 있는 Interactive Playground를 추가했습니다.

## 🐛 수정된 버그
### 1. iOS 18.0 호환성 문제
- **문제**: `systemCyan` 같은 iOS 15.0+ API 사용 시 컴파일 에러 발생
- **해결**: iOS deployment target을 13.0 → 18.0으로 업데이트
- **수정 파일**:
  - `Podfile`: platform 버전 업데이트
  - `DYBlinkObject.podspec`: deployment target 업데이트
  - `project.pbxproj`: 모든 타겟의 deployment target 업데이트

### 2. 검은 화면 문제
- **문제**: Example 앱 실행 시 검은 화면만 표시
- **원인**: SceneDelegate가 SwiftUI ContentView를 로드하려 했으나 실제로는 UIKit ViewController를 사용해야 함
- **해결**:
  - Info.plist에서 UIApplicationSceneManifest 제거
  - UIMainStoryboardFile 추가하여 Main.storyboard 자동 로드
  - AppDelegate에서 Scene 관련 메서드 제거

## ✨ 새로운 기능
### Interactive Playground
사용자가 실시간으로 shape와 animation 조합을 테스트할 수 있는 인터랙티브 플레이그라운드 추가

**주요 기능:**
- **Shape Type Selector**: 6가지 shape 중 선택 (Circle, Triangle, Star, Heart, Pentagon, Hexagon)
- **Animation Type Selector**: 5가지 animation 중 선택 (Alpha, Scale, Rotation, Glow, Color)
- **Create Button**: 선택한 조합으로 실시간 애니메이션 생성
- **Preview Area**: 생성된 애니메이션을 바로 확인할 수 있는 200px 높이의 디스플레이 영역

**UI 개선:**
- 깔끔한 Segment Control 기반 선택 UI
- 그라디언트 효과가 있는 Create 버튼
- ScrollView로 모든 콘텐츠 접근 가능

### 탭 기반 네비게이션
앱 구조를 두 개의 탭으로 재구성하여 더 나은 사용자 경험 제공

**Playground 탭 (기본)**
- SwiftUI 기반 Interactive Playground
- 사용자가 직접 조합을 테스트할 수 있는 공간
- 아이콘: `play.circle.fill`

**Samples 탭**
- UIKit 기반 Example Gallery
- 9가지 미리 만들어진 예제 리스트
- 각 예제의 shape + animation 조합 확인 가능
- 아이콘: `square.grid.3x3.fill`

## 🔧 기타 개선사항
- **Vertical Spacing**: 라벨과 애니메이션 오브젝트 사이 spacing 증가 (100 → 120)
- **코드 정리**: SwiftUI import 제거 등 불필요한 코드 정리

## 📸 스크린샷
<!-- 실제 스크린샷 추가 예정 -->

## 🧪 테스트
- [x] iOS 18.0 시뮬레이터에서 정상 실행 확인
- [x] Interactive Playground에서 모든 조합 테스트
- [x] Samples 탭에서 모든 예제 정상 작동 확인
- [x] 검은 화면 문제 해결 확인

## 📦 변경된 파일
### 설정 파일
- `Example/Podfile`
- `DYBlinkObject.podspec`
- `Example/DYBlinkObject.xcodeproj/project.pbxproj`
- `Example/DYBlinkObject/Info.plist`

### Swift 파일
- `Example/DYBlinkObject/AppDelegate.swift`
- `Example/DYBlinkObject/ViewController.swift`
- `Example/DYBlinkObject/ContentView.swift`
- `Example/DYBlinkObject/InteractivePlaygroundView.swift` (새 파일)

## 📚 관련 이슈
- iOS 18.0 호환성 문제
- Example 앱 검은 화면 이슈

## ✅ 체크리스트
- [x] iOS 18.0에서 정상 작동
- [x] 모든 기존 기능 정상 작동
- [x] 새로운 Interactive Playground 추가
- [x] 코드 정리 및 최적화
- [x] 불필요한 코드 제거

## 💡 향후 개선 사항
- [ ] Interactive Playground에 더 많은 옵션 추가 (duration, from/to 값 조정 등)
- [ ] 생성된 애니메이션 저장 기능
- [ ] 코드 스니펫 복사 기능

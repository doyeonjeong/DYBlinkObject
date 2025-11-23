//
//  ExampleDetailView.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/22/2025.
//

import SwiftUI
import DYBlinkObject


struct ExampleDetailView: View {
    let example: ExampleItem

    var body: some View {
        ZStack {
            Color(UIColor(red: 0.17, green: 0.24, blue: 0.31, alpha: 1.00))
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // Large animated shape for easy GIF recording
                AnimatableShapeView(
                    shapeType: example.shapeType,
                    size: example.size,
                    color: example.color,
                    animations: example.animations
                )
                .frame(width: example.size.width, height: example.size.height)

                VStack(spacing: 12) {
                    Text(example.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(example.subtitle)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))

                    // Code snippet
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Code:")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white.opacity(0.6))

                        Text(generateCodeSnippet())
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundColor(.white.opacity(0.9))
                            .padding(12)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 24)
                }

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func generateCodeSnippet() -> String {
        let shapeTypeString = shapeTypeToString()
        var animationsString = ""

        for (index, animation) in example.animations.enumerated() {
            let animString = animationToString(animation)
            if index == 0 {
                animationsString += "shape.addAnimation(\(animString))"
            } else {
                animationsString += "\n     .addAnimation(\(animString))"
            }
        }

        return """
        let shape = blinkObject.createShape(
            \(shapeTypeString),
            size: CGSize(width: 80, height: 80),
            color: .\(colorToString())
        )
        \(animationsString)
        shape.start()
        """
    }

    private func shapeTypeToString() -> String {
        switch example.shapeType {
        case .circle: return ".circle"
        case .triangle: return ".triangle"
        case .star(let points): return ".star(points: \(points))"
        case .heart: return ".heart"
        case .polygon(let sides): return ".polygon(sides: \(sides))"
        case .roundedPolygon(let sides, let radius): return ".roundedPolygon(sides: \(sides), cornerRadius: \(radius))"
        case .rectangle: return ".rectangle"
        case .customPath: return ".customPath(path: diamondPath)"
        }
    }

    private func animationToString(_ animation: AnimationType) -> String {
        switch animation {
        case .alpha(let from, let to, let duration):
            return ".alpha(from: \(from), to: \(to), duration: \(duration))"
        case .scale(let from, let to, let duration):
            return ".scale(from: \(from), to: \(to), duration: \(duration))"
        case .rotation(let angle, let duration):
            let angleStr = angle == .pi * 2 ? ".pi * 2" : "\(angle)"
            return ".rotation(angle: \(angleStr), duration: \(duration))"
        case .glow(let color, let radius, let duration):
            return ".glow(color: .\(colorName(color)), radius: \(radius), duration: \(duration))"
        case .colorTransition(let from, let to, let duration):
            return ".colorTransition(from: .\(colorName(from)), to: .\(colorName(to)), duration: \(duration))"
        case .position(let from, let to, let duration):
            return ".position(from: CGPoint(x: \(from.x), y: \(from.y)), to: CGPoint(x: \(to.x), y: \(to.y)), duration: \(duration))"
        }
    }

    private func colorToString() -> String {
        colorName(example.color)
    }

    private func colorName(_ color: UIColor) -> String {
        switch color {
        case .systemBlue: return "systemBlue"
        case .systemGreen: return "systemGreen"
        case .systemYellow: return "systemYellow"
        case .systemPink: return "systemPink"
        case .systemPurple: return "systemPurple"
        case .systemOrange: return "systemOrange"
        case .systemTeal: return "systemTeal"
        case .systemIndigo: return "systemIndigo"
        case .systemCyan: return "systemCyan"
        case .systemRed: return "systemRed"
        default: return "systemBlue"
        }
    }
}


struct ExampleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExampleDetailView(example: ExampleItem.examples[0])
        }
    }
}

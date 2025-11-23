//
//  InteractivePlaygroundView.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/23/2025.
//

import SwiftUI
import DYBlinkObject


struct InteractivePlaygroundView: View {
    @State private var selectedShapeIndex = 0
    @State private var selectedAnimationIndex = 0
    @State private var currentAnimationView: UIView?

    let shapeTypes = ["Circle", "Triangle", "Star", "Heart", "Pentagon", "Hexagon"]
    let animationTypes = ["Alpha", "Scale", "Rotation", "Glow", "Color"]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Animation display area
                VStack(spacing: 12) {
                    Text("Preview")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    AnimationDisplayView(animationView: $currentAnimationView)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                // Shape selector
                VStack(alignment: .leading, spacing: 8) {
                    Text("Shape Type")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Picker("Shape", selection: $selectedShapeIndex) {
                        ForEach(0..<shapeTypes.count, id: \.self) { index in
                            Text(shapeTypes[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 20)

                // Animation selector
                VStack(alignment: .leading, spacing: 8) {
                    Text("Animation Type")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Picker("Animation", selection: $selectedAnimationIndex) {
                        ForEach(0..<animationTypes.count, id: \.self) { index in
                            Text(animationTypes[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 20)

                // Create button
                Button(action: createAnimation) {
                    Label("Create Animation", systemImage: "play.circle.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
    }

    func createAnimation() {
        let blinkObject = DYBlinkObject()

        // Create shape
        let shape = getShape(for: selectedShapeIndex)
        let color = getColor(for: selectedShapeIndex)
        let shapeView = blinkObject.createShape(shape, size: CGSize(width: 80, height: 80), color: color)

        // Add animation
        switch selectedAnimationIndex {
        case 0: // Alpha
            shapeView.addAnimation(AnimationType.alpha(from: 1.0, to: 0.3, duration: 1.0))
        case 1: // Scale
            shapeView.addAnimation(AnimationType.scale(from: 1.0, to: 1.3, duration: 1.0))
        case 2: // Rotation
            shapeView.addAnimation(AnimationType.rotation(angle: .pi * 2, duration: 2.0))
        case 3: // Glow
            shapeView.addAnimation(AnimationType.glow(color: color, radius: 20, duration: 1.5))
        case 4: // Color
            shapeView.addAnimation(AnimationType.colorTransition(from: color, to: getAlternateColor(for: color), duration: 2.0))
        default:
            break
        }

        shapeView.start()
        currentAnimationView = shapeView.view
    }

    func getShape(for index: Int) -> ShapeType {
        switch index {
        case 0: return .circle
        case 1: return .triangle
        case 2: return .star(points: 5)
        case 3: return .heart
        case 4: return .polygon(sides: 5)
        case 5: return .roundedPolygon(sides: 6, cornerRadius: 8)
        default: return .circle
        }
    }

    func getColor(for index: Int) -> UIColor {
        switch index {
        case 0: return .systemBlue
        case 1: return .systemGreen
        case 2: return .systemYellow
        case 3: return .systemPink
        case 4: return .systemPurple
        case 5: return .systemTeal
        default: return .systemBlue
        }
    }

    func getAlternateColor(for color: UIColor) -> UIColor {
        if color == .systemBlue { return .systemCyan }
        if color == .systemGreen { return .systemMint }
        if color == .systemYellow { return .systemOrange }
        if color == .systemPink { return .systemRed }
        if color == .systemPurple { return .systemIndigo }
        if color == .systemTeal { return .systemBlue }
        return .systemOrange
    }
}

struct AnimationDisplayView: UIViewRepresentable {
    @Binding var animationView: UIView?

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Remove previous animation view
        uiView.subviews.forEach { $0.removeFromSuperview() }

        // Add new animation view if exists
        if let animationView = animationView {
            animationView.translatesAutoresizingMaskIntoConstraints = false
            uiView.addSubview(animationView)

            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: uiView.centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: uiView.centerYAnchor)
            ])
        }
    }
}


struct InteractivePlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        InteractivePlaygroundView()
    }
}

//
//  InteractivePlaygroundView.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/23/2025.
//

import SwiftUI
import DYBlinkObject


struct InteractivePlaygroundView: View {
    @State private var currentAnimationView: UIView?

    var body: some View {
        VStack(spacing: 0) {
            // Preview area at top
            VStack(spacing: 12) {
                Text("Preview")
                    .font(.headline)
                    .foregroundColor(.secondary)

                AnimationDisplayView(animationView: $currentAnimationView)
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)

            // Tab view for Preset and Custom
            TabView {
                PresetPlaygroundView(currentAnimationView: $currentAnimationView)
                    .tabItem {
                        Label("Preset", systemImage: "square.grid.2x2")
                    }

                CustomPlaygroundView(currentAnimationView: $currentAnimationView)
                    .tabItem {
                        Label("Custom", systemImage: "slider.horizontal.3")
                    }
            }
        }
    }
}

// MARK: - Preset Playground View
struct PresetPlaygroundView: View {
    @Binding var currentAnimationView: UIView?
    @State private var selectedShapeIndex = 0
    @State private var selectedAnimationIndex = 0

    let shapeTypes = ["Circle", "Triangle", "Star", "Heart", "Pentagon", "Hexagon"]
    let animationTypes = ["Alpha", "Scale", "Rotation", "Glow"]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
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
                .padding(.top, 20)

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
}

// MARK: - Custom Playground View
struct CustomPlaygroundView: View {
    @Binding var currentAnimationView: UIView?

    @State private var selectedShapeIndex = 0
    @State private var selectedColor = Color.blue
    @State private var hexInput = "007AFF"

    @State private var alphaFrom: Double = 1.0
    @State private var alphaTo: Double = 0.3
    @State private var duration: Double = 1.0
    @State private var rotationAngle: Double = 360
    @State private var scaleFrom: Double = 1.0
    @State private var scaleTo: Double = 1.3
    @State private var glowRadius: Double = 20

    @State private var selectedAnimationType = 0

    let shapeTypes = ["Circle", "Triangle", "Star", "Heart", "Pentagon", "Hexagon"]
    let animationTypes = ["Alpha", "Scale", "Rotation", "Glow"]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
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
                .padding(.top, 20)

                // Color picker
                VStack(alignment: .leading, spacing: 12) {
                    Text("Color")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    ColorPicker("Select Color", selection: $selectedColor)
                        .onChange(of: selectedColor) { newColor in
                            hexInput = newColor.toHex()
                        }

                    HStack {
                        Text("Hex:")
                            .font(.subheadline)
                        TextField("#", text: $hexInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.allCharacters)
                            .onChange(of: hexInput) { newHex in
                                if let color = Color(hex: newHex) {
                                    selectedColor = color
                                }
                            }
                    }
                }
                .padding(.horizontal, 20)

                // Animation type
                VStack(alignment: .leading, spacing: 8) {
                    Text("Animation Type")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Picker("Animation", selection: $selectedAnimationType) {
                        ForEach(0..<animationTypes.count, id: \.self) { index in
                            Text(animationTypes[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 20)

                // Animation parameters based on type
                VStack(alignment: .leading, spacing: 16) {
                    Text("Parameters")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    // Duration (common for all)
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Duration")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(String(format: "%.1fs", duration))
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        Slider(value: $duration, in: 0.1...5.0, step: 0.1)
                    }

                    // Type-specific parameters
                    switch selectedAnimationType {
                    case 0: // Alpha
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Alpha From")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(String(format: "%.2f", alphaFrom))
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            Slider(value: $alphaFrom, in: 0.0...1.0, step: 0.05)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Alpha To")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(String(format: "%.2f", alphaTo))
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            Slider(value: $alphaTo, in: 0.0...1.0, step: 0.05)
                        }

                    case 1: // Scale
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Scale From")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(String(format: "%.2f", scaleFrom))
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            Slider(value: $scaleFrom, in: 0.1...2.0, step: 0.1)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Scale To")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(String(format: "%.2f", scaleTo))
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            Slider(value: $scaleTo, in: 0.1...2.0, step: 0.1)
                        }

                    case 2: // Rotation
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Rotation Angle")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(Int(rotationAngle))°")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            Slider(value: $rotationAngle, in: 0...720, step: 15)
                        }

                    case 3: // Glow
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Glow Radius")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(Int(glowRadius))pt")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            Slider(value: $glowRadius, in: 0...50, step: 1)
                        }

                    default:
                        EmptyView()
                    }
                }
                .padding(.horizontal, 20)

                // Create button
                Button(action: createCustomAnimation) {
                    Label("Create Animation", systemImage: "wand.and.stars")
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

    func createCustomAnimation() {
        let blinkObject = DYBlinkObject()

        // Create shape with selected color
        let shape = getShape(for: selectedShapeIndex)
        let uiColor = UIColor(selectedColor)
        let shapeView = blinkObject.createShape(shape, size: CGSize(width: 80, height: 80), color: uiColor)

        // Add animation based on type
        switch selectedAnimationType {
        case 0: // Alpha
            shapeView.addAnimation(AnimationType.alpha(from: alphaFrom, to: alphaTo, duration: duration))
        case 1: // Scale
            shapeView.addAnimation(AnimationType.scale(from: scaleFrom, to: scaleTo, duration: duration))
        case 2: // Rotation
            let radians = rotationAngle * .pi / 180
            shapeView.addAnimation(AnimationType.rotation(angle: radians, duration: duration))
        case 3: // Glow
            shapeView.addAnimation(AnimationType.glow(color: uiColor, radius: glowRadius, duration: duration))
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


// MARK: - Color Extensions for Hex Support
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        let length = hexSanitized.count
        let r, g, b: Double

        if length == 6 {
            r = Double((rgb & 0xFF0000) >> 16) / 255.0
            g = Double((rgb & 0x00FF00) >> 8) / 255.0
            b = Double(rgb & 0x0000FF) / 255.0
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b)
    }

    func toHex() -> String {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return "000000"
        }

        let r = components[0]
        let g = components[1]
        let b = components[2]

        return String(format: "%02X%02X%02X",
                     Int(r * 255),
                     Int(g * 255),
                     Int(b * 255))
    }
}

struct InteractivePlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        InteractivePlaygroundView()
    }
}

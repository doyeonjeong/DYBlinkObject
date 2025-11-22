//
//  ExampleItem.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/22/2025.
//

import Foundation
import UIKit
import DYBlinkObject

struct ExampleItem: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let shapeType: ShapeType
    let size: CGSize
    let color: UIColor
    let animations: [AnimationType]

    static let examples: [ExampleItem] = [
        ExampleItem(
            id: 1,
            title: "Circle with Alpha",
            subtitle: "Fade in/out animation",
            shapeType: .circle,
            size: CGSize(width: 120, height: 120),
            color: .systemBlue,
            animations: [.alpha(from: 1.0, to: 0.3, duration: 1.0)]
        ),
        ExampleItem(
            id: 2,
            title: "Triangle with Scale",
            subtitle: "Grow and shrink animation",
            shapeType: .triangle,
            size: CGSize(width: 120, height: 120),
            color: .systemGreen,
            animations: [.scale(from: 1.0, to: 1.3, duration: 1.5)]
        ),
        ExampleItem(
            id: 3,
            title: "Rotating Star",
            subtitle: "Continuous rotation",
            shapeType: .star(points: 5),
            size: CGSize(width: 120, height: 120),
            color: .systemYellow,
            animations: [.rotation(angle: .pi * 2, duration: 3.0)]
        ),
        ExampleItem(
            id: 4,
            title: "Glowing Heart",
            subtitle: "Pulsating glow effect",
            shapeType: .heart,
            size: CGSize(width: 120, height: 120),
            color: .systemPink,
            animations: [.glow(color: .systemPink, radius: 20, duration: 1.5)]
        ),
        ExampleItem(
            id: 5,
            title: "Pentagon Color Transition",
            subtitle: "Smooth color change",
            shapeType: .polygon(sides: 5),
            size: CGSize(width: 120, height: 120),
            color: .systemPurple,
            animations: [.colorTransition(from: .systemPurple, to: .systemOrange, duration: 2.0)]
        ),
        ExampleItem(
            id: 6,
            title: "Hexagon Multi-Animation",
            subtitle: "Scale + Alpha combined",
            shapeType: .roundedPolygon(sides: 6, cornerRadius: 8),
            size: CGSize(width: 120, height: 120),
            color: .systemTeal,
            animations: [
                .scale(from: 1.0, to: 1.2, duration: 1.0),
                .alpha(from: 1.0, to: 0.5, duration: 1.0)
            ]
        ),
        ExampleItem(
            id: 7,
            title: "Diamond Color Shift",
            subtitle: "Custom path with color transition",
            shapeType: .customPath(path: {
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 60, y: 0))
                path.addLine(to: CGPoint(x: 120, y: 60))
                path.addLine(to: CGPoint(x: 60, y: 120))
                path.addLine(to: CGPoint(x: 0, y: 60))
                path.close()
                return path
            }()),
            size: CGSize(width: 120, height: 120),
            color: .systemIndigo,
            animations: [.colorTransition(from: .systemIndigo, to: .systemCyan, duration: 2.0)]
        )
    ]
}

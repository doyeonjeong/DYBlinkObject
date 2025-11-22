//
//  AnimatableShapeView.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/22/2025.
//

import SwiftUI
import DYBlinkObject

@available(iOS 13.0, *)
struct AnimatableShapeView: UIViewRepresentable {
    let shapeType: ShapeType
    let size: CGSize
    let color: UIColor
    let animations: [AnimationType]

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.backgroundColor = .clear

        let blinkObject = DYBlinkObject()
        let shape = blinkObject.createShape(shapeType, size: size, color: color)

        // Add all animations
        var animatableView = shape
        for animation in animations {
            animatableView = animatableView.addAnimation(animation)
        }
        animatableView.start()

        // Add shape view to container
        container.addSubview(shape.view)
        shape.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shape.view.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            shape.view.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            shape.view.widthAnchor.constraint(equalToConstant: size.width),
            shape.view.heightAnchor.constraint(equalToConstant: size.height)
        ])

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates needed - animations run continuously
    }
}

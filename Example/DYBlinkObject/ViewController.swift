//
//  ViewController.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 03/10/2023.
//  Copyright (c) 2023 doyeonjeong. All rights reserved.
//

import UIKit
import DYBlinkObject

class ViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.17, green: 0.24, blue: 0.31, alpha: 1.00)
        setupScrollView()
        setupObjects()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentStackView.axis = .vertical
        contentStackView.spacing = 40
        contentStackView.alignment = .center
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    func setupObjects() {
        let blinkObject = DYBlinkObject()

        // Title
        let titleLabel = makeTextLabel(text: "DYBlinkObject v2.0", size: 28, bold: true)
        contentStackView.addArrangedSubview(titleLabel)

        addSpacer(height: 20)

        // 1. Circle with color transition
        addSection(
            title: "Circle - Color Transition",
            description: "Red ↔ Yellow",
            view: blinkObject.draw(
                shape: .circle(radius: 60),
                animations: [
                    .colorTransition(from: .systemRed, to: .systemYellow, duration: 2.0)
                ]
            )
        )

        // 2. Star with rotation
        addSection(
            title: "Star - Rotation",
            description: "5 points, rotating",
            view: blinkObject.draw(
                shape: .star(points: 5, radius: 60),
                color: .systemYellow,
                animations: [
                    .rotation(duration: 3.0)
                ]
            )
        )

        // 3. Heart with scale + glow
        let heart = blinkObject.draw(shape: .heart(size: 100), color: .systemPink)
            .addAnimation(.scale(from: 1.0, to: 1.3, duration: 1.5))
            .addAnimation(.glow(color: .systemPink, radius: 15, duration: 1.5))

        addSection(
            title: "Heart - Scale + Glow",
            description: "Pulsing with glow effect",
            view: heart
        )

        // 4. Triangle with multiple effects
        let triangle = blinkObject.draw(shape: .triangle(size: 100), color: .systemGreen)
            .addAnimation(.colorTransition(from: .systemGreen, to: .systemCyan, duration: 2.5))
            .addAnimation(.rotation(duration: 4.0))

        addSection(
            title: "Triangle - Color + Rotation",
            description: "Green ↔ Cyan + rotating",
            view: triangle
        )

        // 5. Hexagon (Polygon)
        addSection(
            title: "Hexagon - Alpha",
            description: "Regular 6-sided polygon",
            view: blinkObject.draw(
                shape: .polygon(sides: 6, radius: 60),
                color: .systemPurple,
                animations: [
                    .alpha(to: 0.3, duration: 1.5)
                ]
            )
        )

        // 6. Rounded Pentagon
        let pentagon = blinkObject.draw(
            shape: .roundedPolygon(sides: 5, radius: 60, cornerRadius: 15),
            color: .systemOrange
        )
        .addAnimation(.scale(from: 1.0, to: 1.2, duration: 2.0))
        .addAnimation(.rotation(duration: 5.0, clockwise: false))

        addSection(
            title: "Rounded Pentagon - Scale + Rotation",
            description: "5 sides, rounded corners",
            view: pentagon
        )

        // 7. Rectangle with position
        addSection(
            title: "Rectangle - Position",
            description: "Moving up and down",
            view: blinkObject.draw(
                shape: .rectangle(width: 150, height: 80, cornerRadius: 15),
                color: .systemBlue,
                animations: [
                    .position(offsetY: 20, duration: 1.0)
                ]
            )
        )

        // 8. Custom path - Diamond
        let diamondPath = createDiamondPath(size: 100)
        let diamond = blinkObject.draw(
            shape: .custom(path: diamondPath, size: CGSize(width: 100, height: 100)),
            animations: [
                .colorTransition(from: .systemIndigo, to: .systemPink, duration: 2.0),
                .glow(color: .systemIndigo, radius: 12, duration: 2.0)
            ]
        )

        addSection(
            title: "Custom Diamond - Color + Glow",
            description: "Custom path example",
            view: diamond
        )

        // 9. Legacy API example
        let legacyRect = blinkObject.draw(width: 200, height: 60, radius: 10, color: .white)
        blinkObject.addBlinkingAnimation(to: legacyRect, withDuration: 1.5, delay: 0.0, minAlpha: 0.4)

        addSection(
            title: "Legacy API (v1.0)",
            description: "Backward compatible",
            view: legacyRect
        )

        // Final spacer
        addSpacer(height: 40)
    }

    private func addSection(title: String, description: String, view: UIView) {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = makeTextLabel(text: title, size: 20, bold: true)
        let descLabel = makeTextLabel(text: description, size: 16)

        container.addSubview(titleLabel)
        container.addSubview(descLabel)
        container.addSubview(view)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            view.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 15),
            view.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        contentStackView.addArrangedSubview(container)
    }

    private func addSpacer(height: CGFloat) {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        contentStackView.addArrangedSubview(spacer)
    }

    private func makeTextLabel(text: String, size: CGFloat, bold: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = bold ? UIFont.boldSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createDiamondPath(size: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: size / 2, y: 0))
        path.addLine(to: CGPoint(x: size, y: size / 2))
        path.addLine(to: CGPoint(x: size / 2, y: size))
        path.addLine(to: CGPoint(x: 0, y: size / 2))
        path.close()
        return path
    }
}

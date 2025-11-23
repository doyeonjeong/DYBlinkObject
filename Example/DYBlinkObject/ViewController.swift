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
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.17, green: 0.24, blue: 0.31, alpha: 1.00)
        setupScrollView()
        setupV2Examples()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupV2Examples() {
        let blinkObject = DYBlinkObject()
        var currentY: CGFloat = 60
        let spacing: CGFloat = 120

        // Title
        let titleLabel = makeTextLabel(text: "DYBlinkObject Samples", size: 28, weight: .bold)
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: currentY),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        currentY += 60

        // Example 1: Circle with Alpha Animation
        let example1 = blinkObject.createShape(.circle, size: CGSize(width: 80, height: 80), color: .systemBlue)
        example1.addAnimation(AnimationType.alpha(from: 1.0, to: 0.3, duration: 1.0))
        example1.start()

        let label1 = makeTextLabel(text: "Circle + Alpha Animation", size: 16)
        addExample(view: example1.view, label: label1, yPosition: &currentY, spacing: spacing)

        // Example 2: Triangle with Scale Animation
        let example2 = blinkObject.createShape(.triangle, size: CGSize(width: 80, height: 80), color: .systemGreen)
        example2.addAnimation(AnimationType.scale(from: 1.0, to: 1.3, duration: 1.5))
        example2.start()

        let label2 = makeTextLabel(text: "Triangle + Scale Animation", size: 16)
        addExample(view: example2.view, label: label2, yPosition: &currentY, spacing: spacing)

        // Example 3: Star with Rotation
        let example3 = blinkObject.createShape(.star(points: 5), size: CGSize(width: 80, height: 80), color: .systemYellow)
        example3.addAnimation(AnimationType.rotation(angle: .pi * 2, duration: 3.0))
        example3.start()

        let label3 = makeTextLabel(text: "Star + Rotation Animation", size: 16)
        addExample(view: example3.view, label: label3, yPosition: &currentY, spacing: spacing)

        // Example 4: Heart with Glow
        let example4 = blinkObject.createShape(.heart, size: CGSize(width: 80, height: 80), color: .systemPink)
        example4.addAnimation(AnimationType.glow(color: .systemPink, radius: 20, duration: 1.5))
        example4.start()

        let label4 = makeTextLabel(text: "Heart + Glow Animation", size: 16)
        addExample(view: example4.view, label: label4, yPosition: &currentY, spacing: spacing)

        // Example 5: Pentagon with Color Transition
        let example5 = blinkObject.createShape(.polygon(sides: 5), size: CGSize(width: 80, height: 80), color: .systemPurple)
        example5.addAnimation(AnimationType.colorTransition(from: .systemPurple, to: .systemOrange, duration: 2.0))
        example5.start()

        let label5 = makeTextLabel(text: "Pentagon + Color Transition", size: 16)
        addExample(view: example5.view, label: label5, yPosition: &currentY, spacing: spacing)

        // Example 6: Rounded Hexagon with Multiple Animations
        let example6 = blinkObject.createShape(.roundedPolygon(sides: 6, cornerRadius: 8), size: CGSize(width: 80, height: 80), color: .systemTeal)
        example6
            .addAnimation(AnimationType.scale(from: 1.0, to: 1.2, duration: 1.0))
            .addAnimation(AnimationType.alpha(from: 1.0, to: 0.5, duration: 1.0))
        example6.start()

        let label6 = makeTextLabel(text: "Hexagon + Scale + Alpha", size: 16)
        addExample(view: example6.view, label: label6, yPosition: &currentY, spacing: spacing)

        // Example 7: Rectangle with Rotation + Glow
        let example7 = blinkObject.createShape(.rectangle, size: CGSize(width: 80, height: 80), color: .systemRed)
        example7
            .addAnimation(AnimationType.rotation(angle: .pi * 2, duration: 4.0))
            .addAnimation(AnimationType.glow(color: .systemRed, radius: 15, duration: 1.5))
        example7.start()

        let label7 = makeTextLabel(text: "Rectangle + Rotation + Glow", size: 16)
        addExample(view: example7.view, label: label7, yPosition: &currentY, spacing: spacing)

        // Example 8: Custom Path (Diamond) with Color Transition
        let diamondPath = UIBezierPath()
        diamondPath.move(to: CGPoint(x: 40, y: 0))
        diamondPath.addLine(to: CGPoint(x: 80, y: 40))
        diamondPath.addLine(to: CGPoint(x: 40, y: 80))
        diamondPath.addLine(to: CGPoint(x: 0, y: 40))
        diamondPath.close()

        let example8 = blinkObject.createShape(.customPath(path: diamondPath), size: CGSize(width: 80, height: 80), color: .systemIndigo)
        example8.addAnimation(AnimationType.colorTransition(from: .systemIndigo, to: .systemCyan, duration: 2.0))
        example8.start()

        let label8 = makeTextLabel(text: "Custom Diamond + Color Transition", size: 16)
        addExample(view: example8.view, label: label8, yPosition: &currentY, spacing: spacing)

        // Example 9: v1.0 Compatibility Test
        let v1Example = blinkObject.draw(width: 200, height: 50, radius: 10, color: .white)
        blinkObject.addBlinkingAnimation(to: v1Example, withDuration: 1.0, delay: 0.0, minAlpha: 0.3)

        let label9 = makeTextLabel(text: "v1.0 Compatibility (Legacy API)", size: 16)
        addExample(view: v1Example, label: label9, yPosition: &currentY, spacing: spacing)

        // Set content size
        contentView.heightAnchor.constraint(equalToConstant: currentY + 40).isActive = true
    }

    private func addExample(view: UIView, label: UILabel, yPosition: inout CGFloat, spacing: CGFloat) {
        contentView.addSubview(view)
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: yPosition),
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 12),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        yPosition += spacing
    }

    private func makeTextLabel(text: String, size: CGFloat, weight: UIFont.Weight = .regular) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
}

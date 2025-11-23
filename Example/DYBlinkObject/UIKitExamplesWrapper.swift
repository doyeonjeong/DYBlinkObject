//
//  UIKitExamplesWrapper.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/22/2025.
//

import SwiftUI
import UIKit


struct UIKitExamplesWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // No updates needed
    }
}

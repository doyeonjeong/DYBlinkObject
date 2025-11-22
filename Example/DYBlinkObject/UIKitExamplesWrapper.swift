//
//  UIKitExamplesWrapper.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/22/2025.
//

import SwiftUI
import UIKit

@available(iOS 13.0, *)
struct UIKitExamplesWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // No updates needed
    }
}

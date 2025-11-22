//
//  SwiftUIExamplesView.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/22/2025.
//

import SwiftUI

@available(iOS 13.0, *)
struct SwiftUIExamplesView: View {
    var body: some View {
        NavigationView {
            List(ExampleItem.examples) { example in
                NavigationLink(destination: ExampleDetailView(example: example)) {
                    HStack(spacing: 16) {
                        // Small preview
                        AnimatableShapeView(
                            shapeType: example.shapeType,
                            size: CGSize(width: 50, height: 50),
                            color: example.color,
                            animations: example.animations
                        )
                        .frame(width: 50, height: 50)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(example.title)
                                .font(.headline)
                            Text(example.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("SwiftUI Examples")
        }
    }
}

@available(iOS 13.0, *)
struct SwiftUIExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIExamplesView()
    }
}

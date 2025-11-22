//
//  ContentView.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/22/2025.
//

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
    var body: some View {
        TabView {
            SwiftUIExamplesView()
                .tabItem {
                    Image(systemName: "swift")
                    Text("SwiftUI")
                }

            UIKitExamplesWrapper()
                .tabItem {
                    Image(systemName: "rectangle.grid.3x2")
                    Text("UIKit")
                }
        }
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
